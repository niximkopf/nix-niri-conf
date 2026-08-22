{ lib, stdenv, fetchFromGitHub, ncurses }:

stdenv.mkDerivation {
  pname = "momoisay";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "Mon4sm";
    repo = "momoisay";
    rev = "v1.1.1";
    hash = "sha256-tvVAlE+BZZBI0y/9tQIOX6n07UebWJOPQiNTBFNSyKM=";
  };

  buildInputs = [ ncurses ];

  NIX_CFLAGS_COMPILE = "-I${lib.getDev ncurses}/include";
  NIX_LDFLAGS = "-L${lib.getLib ncurses}/lib";

  installPhase = ''
    mkdir -p $out/bin
    cp momoisay $out/bin/
  '';

  meta = with lib; {
    description = "CLI program like cowsay but with Saiba Momoi";
    homepage = "https://github.com/Mon4sm/momoisay";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
