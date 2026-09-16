{ stdenvNoCC, python3 }:
stdenvNoCC.mkDerivation {
  pname = "arona-cursor-scaled";
  version = "1.0";
  src = ../../assets/cursor/arona-cursor;
  nativeBuildInputs = [ python3 ];
  installPhase = ''
    mkdir -p $out/share/icons
    python3 ${../../assets/cursor/upscale_xcursor.py} \
      ${../../assets/cursor/arona-cursor} \
      $out/share/icons/arona-cursor \
      2
  '';
}