{ stdenvNoCC, python3 }:
stdenvNoCC.mkDerivation {
  pname = "mornye-wuwa-cursors-scaled";
  version = "1.0";
  src = ../../../assets/cursor/mornye-wuwa-cursors;
  nativeBuildInputs = [ python3 ];
  installPhase = ''
    mkdir -p $out/share/icons
    python3 ${../../../assets/cursor/upscale_xcursor.py} \
      ${../../../assets/cursor/mornye-wuwa-cursors} \
      $out/share/icons/mornye-wuwa-cursors \
      1.25
  '';
}