{ stdenvNoCC, python3 }:
stdenvNoCC.mkDerivation {
  pname = "hoshino-ai-pixel-cursors-scaled";
  version = "1.0";
  src = ../../assets/cursor/hoshino-ai-pixel-cursors;
  nativeBuildInputs = [ python3 ];
  installPhase = ''
    mkdir -p $out/share/icons
    python3 ${../../assets/cursor/upscale_xcursor.py} \
      ${../../assets/cursor/hoshino-ai-pixel-cursors} \
      $out/share/icons/hoshino-ai-pixel-cursors \
      2
  '';
}