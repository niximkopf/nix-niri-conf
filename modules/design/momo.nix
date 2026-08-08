# momoisay ist nicht in nixpkgs gepackt - eigene Derivation, die den
# Build aus dem Makefile des Projekts nachbaut.
# https://github.com/Mon4sm/momoisay
{ pkgs, lib, ... }:

let
  momoisay = pkgs.stdenv.mkDerivation rec {
    pname   = "momoisay";
    version = "1.1.1"; # aktuellster Release-Tag zum Zeitpunkt 08.08.26

    src = pkgs.fetchFromGitHub {
      owner = "Mon4sm";
      repo  = "momoisay";
      rev   = "v${version}";
      hash = lib.fakeHash;
    };

    buildInputs = [ pkgs.ncurses ];

    buildPhase = ''
      runHook preBuild
      make
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      install -Dm755 momoisay $out/bin/momoisay
      runHook postInstall
    '';

    meta = with lib; {
      description = "cowsay-artiges CLI-Tool mit Momoi aus Blue Archive statt einer Kuh";
      homepage    = "https://github.com/Mon4sm/momoisay";
      license     = licenses.gpl3Only;
      platforms   = platforms.unix;
      mainProgram = "momoisay";
    };
  };
in
{
  environment.systemPackages = [ momoisay ];
}