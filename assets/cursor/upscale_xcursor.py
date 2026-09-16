#!/usr/bin/env python3
"""
Skaliert ein Xcursor-Theme (bitmap-basiert) per Nearest-Neighbor um einen
ganzzahligen Faktor hoch, ohne den Pixel-Art-Look zu verwischen.

Nutzung: upscale_xcursor.py <input_theme_dir> <output_theme_dir> <faktor>
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
        c_header_size, c_type, c_subtype, c_version = struct.unpack_from(
            "<IIII", data, position
        )
        # Die 16-Byte-Basis-Chunk-Kopfzeile, NICHT c_header_size (der Wert
        # "header_size" umfasst bei Image-Chunks zusaetzlich schon die
        # folgenden 20 Byte Bildmetadaten, siehe Xcursor-Dateiformat-Spec).
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
    """Nearest-Neighbor-Upscale eines ARGB32-Pixelpuffers."""
    out = bytearray(width * factor * height * factor * 4)
    new_w = width * factor
    for y in range(height):
        src_row_start = y * width * 4
        src_row = pixels[src_row_start : src_row_start + width * 4]
        # Zeile horizontal strecken
        stretched = bytearray(new_w * 4)
        for x in range(width):
            px = src_row[x * 4 : x * 4 + 4]
            for k in range(factor):
                dst = (x * factor + k) * 4
                stretched[dst : dst + 4] = px
        # Zeile vertikal duplizieren
        for k in range(factor):
            dst_y = y * factor + k
            dst_start = dst_y * new_w * 4
            out[dst_start : dst_start + new_w * 4] = stretched
    return bytes(out)


def write_xcursor(path, frames):
    ntoc = len(frames)
    header_size = 16
    toc_size = ntoc * 12
    header = struct.pack("<4sIII", MAGIC, header_size, FILE_VERSION, ntoc)

    # TOC-Positionen erst berechnen: header + toc, dann Chunks nacheinander
    positions = []
    pos = header_size + toc_size
    base_chunk_header_size = 16  # header_size,type,subtype,version
    image_meta_size = 20  # width,height,xhot,yhot,delay
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

    src_dir, dst_dir, factor = sys.argv[1], sys.argv[2], int(sys.argv[3])
    os.makedirs(dst_dir, exist_ok=True)

    # index.theme (und ggf. weitere Metadateien) unveraendert kopieren
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
                print(
                    f"UEBERSPRINGE {name}: inkonsistente Framegroesse "
                    f"(w={fr['width']} h={fr['height']} pixels={len(fr['pixels'])})"
                )
                continue
            new_pixels = upscale_pixels(
                fr["pixels"], fr["width"], fr["height"], factor
            )
            new_frames.append(
                {
                    "size": fr["size"] * factor,
                    "width": fr["width"] * factor,
                    "height": fr["height"] * factor,
                    "xhot": fr["xhot"] * factor,
                    "yhot": fr["yhot"] * factor,
                    "delay": fr["delay"],
                    "pixels": new_pixels,
                }
            )
        write_xcursor(os.path.join(dst_cursor_dir, name), new_frames)
        print(f"skaliert: {name} ({len(frames)} frame(s))")

    for name, target in symlinks.items():
        link_path = os.path.join(dst_cursor_dir, name)
        if os.path.lexists(link_path):
            os.remove(link_path)
        os.symlink(target, link_path)
        print(f"symlink:  {name} -> {target}")


if __name__ == "__main__":
    main()
