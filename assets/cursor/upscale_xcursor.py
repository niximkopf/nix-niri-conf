#!/usr/bin/env python3
"""
Skaliert ein Xcursor-Theme (bitmap-basiert) per Nearest-Neighbor um einen
(auch nicht-ganzzahligen) Faktor, ohne den Pixel-Art-Look zu verwischen.

Nutzung: upscale_xcursor.py <input_theme_dir> <output_theme_dir> <faktor>
Faktor kann z.B. 1.5, 2, 2.5 etc. sein.
"""
import os
import struct
import shutil
import sys

MAGIC = b"Xcur"
IMAGE_TYPE = 0xFFFD0002
FILE_VERSION = 0x00010000
IMAGE_VERSION = 1


def read_xcursor(path):
    with open(path, "rb") as f:
        data = f.read()

    magic, header_size, version, ntoc = struct.unpack_from("<4sIII", data, 0)
    if magic != MAGIC:
        raise ValueError(f"{path} ist keine gueltige Xcursor-Datei")

    toc = []
    off = header_size
    for _ in range(ntoc):
        chunk_type, subtype, position = struct.unpack_from("<III", data, off)
        toc.append((chunk_type, subtype, position))
        off += 12

    frames = []
    for chunk_type, subtype, position in toc:
        if chunk_type != IMAGE_TYPE:
            continue
        p = position + 16
        width, height, xhot, yhot, delay = struct.unpack_from("<IIIII", data, p)
        p += 20
        npixels = width * height * 4
        pixels = data[p : p + npixels]
        frames.append(
            {
                "size": subtype,
                "width": width,
                "height": height,
                "xhot": xhot,
                "yhot": yhot,
                "delay": delay,
                "pixels": pixels,
            }
        )
    return frames


def upscale_pixels(pixels, width, height, factor):
    """Nearest-Neighbor-Upscale eines ARGB32-Pixelpuffers um einen
    beliebigen (auch gebrochenen) Faktor."""
    new_w = max(1, round(width * factor))
    new_h = max(1, round(height * factor))
    out = bytearray(new_w * new_h * 4)

    # Fuer jede Ziel-Spalte/-Zeile die naechstliegende Quell-Spalte/-Zeile
    # vorab berechnen (klassisches Nearest-Neighbor-Resampling).
    src_x = [min(width - 1, int(x / factor)) for x in range(new_w)]
    src_y = [min(height - 1, int(y / factor)) for y in range(new_h)]

    for dy, sy in enumerate(src_y):
        src_row_start = sy * width * 4
        dst_row_start = dy * new_w * 4
        for dx, sx in enumerate(src_x):
            s = src_row_start + sx * 4
            d = dst_row_start + dx * 4
            out[d : d + 4] = pixels[s : s + 4]

    return bytes(out), new_w, new_h


def write_xcursor(path, frames):
    ntoc = len(frames)
    header_size = 16
    toc_size = ntoc * 12
    header = struct.pack("<4sIII", MAGIC, header_size, FILE_VERSION, ntoc)

    positions = []
    pos = header_size + toc_size
    base_chunk_header_size = 16
    image_meta_size = 20
    chunk_header_field = base_chunk_header_size + image_meta_size  # = 36
    for fr in frames:
        positions.append(pos)
        pos += chunk_header_field + len(fr["pixels"])

    toc = b""
    for fr, p in zip(frames, positions):
        toc += struct.pack("<III", IMAGE_TYPE, fr["size"], p)

    body = b""
    for fr in frames:
        body += struct.pack(
            "<IIII",
            chunk_header_field,
            IMAGE_TYPE,
            fr["size"],
            IMAGE_VERSION,
        )
        body += struct.pack(
            "<IIIII",
            fr["width"],
            fr["height"],
            fr["xhot"],
            fr["yhot"],
            fr["delay"],
        )
        body += fr["pixels"]

    with open(path, "wb") as f:
        f.write(header + toc + body)


def main():
    if len(sys.argv) != 4:
        print(__doc__)
        sys.exit(1)

    src_dir, dst_dir, factor = sys.argv[1], sys.argv[2], float(sys.argv[3])
    os.makedirs(dst_dir, exist_ok=True)

    for name in os.listdir(src_dir):
        src_path = os.path.join(src_dir, name)
        if name == "cursors":
            continue
        if os.path.isfile(src_path):
            shutil.copy2(src_path, os.path.join(dst_dir, name))

    src_cursor_dir = os.path.join(src_dir, "cursors")
    dst_cursor_dir = os.path.join(dst_dir, "cursors")
    os.makedirs(dst_cursor_dir, exist_ok=True)

    symlinks = {}
    real_files = []
    for name in os.listdir(src_cursor_dir):
        p = os.path.join(src_cursor_dir, name)
        if os.path.islink(p):
            symlinks[name] = os.readlink(p)
        else:
            real_files.append(name)

    for name in real_files:
        src_path = os.path.join(src_cursor_dir, name)
        try:
            frames = read_xcursor(src_path)
        except Exception as e:
            print(f"UEBERSPRINGE {name}: {e}")
            continue

        new_frames = []
        for fr in frames:
            if len(fr["pixels"]) != fr["width"] * fr["height"] * 4:
                print(f"UEBERSPRINGE Frame in {name}: inkonsistente Framegroesse")
                continue
            new_pixels, new_w, new_h = upscale_pixels(
                fr["pixels"], fr["width"], fr["height"], factor
            )
            new_frames.append(
                {
                    "size": max(1, round(fr["size"] * factor)),
                    "width": new_w,
                    "height": new_h,
                    "xhot": min(new_w - 1, round(fr["xhot"] * factor)),
                    "yhot": min(new_h - 1, round(fr["yhot"] * factor)),
                    "delay": fr["delay"],
                    "pixels": new_pixels,
                }
            )
        write_xcursor(os.path.join(dst_cursor_dir, name), new_frames)
        print(f"skaliert: {name} ({len(frames)} frame(s)) -> {new_frames[0]['width']}x{new_frames[0]['height']}")

    for name, target in symlinks.items():
        link_path = os.path.join(dst_cursor_dir, name)
        if os.path.lexists(link_path):
            os.remove(link_path)
        os.symlink(target, link_path)
        print(f"symlink:  {name} -> {target}")


if __name__ == "__main__":
    main()
