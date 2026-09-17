{ stdenvNoCC, python3 }:
stdenvNoCC.mkDerivation {
  pname = "silver-wolf-honkai-cursors-scaled";
  version = "1.0";
  src = ../../../assets/cursor/silver-wolf-honkai-cursors;
  nativeBuildInputs = [ python3 ];
  installPhase = ''
    mkdir -p $out/share/icons
    python3 ${../../../assets/cursor/upscale_xcursor.py} \
      ${../../../assets/cursor/silver-wolf-honkai-cursors} \
      $out/share/icons/silver-wolf-honkai-cursors \
      2
  '';
}