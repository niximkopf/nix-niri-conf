{ lib, python3Packages, fetchPypi, ffmpeg, mpv }:

python3Packages.buildPythonApplication rec {
  pname = "aniworld";
  version = "5.0.6";
  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    dist = "py3";
    python = "py3";
    sha256 = "2826050b650993e6eb6392d56bf738caefeea06f30f8f1363e8bf2161e09ad00";
  };

  dependencies = with python3Packages; [
    certifi
    niquests
    npyscreen
    ffmpeg-python
    python-dotenv
    rich
    flask
    flask-wtf
    waitress
    cryptography
    curl-cffi
    packaging
    urllib3
  ];

  pythonRemoveDeps = [ "patchright" ];

  makeWrapperArgs = [
    "--prefix" "PATH" ":" (lib.makeBinPath [ ffmpeg mpv ])
  ];

  meta = {
    description = "AniWorld Downloader";
    homepage = "https://github.com/phoenixthrush/AniWorld-Downloader";
    license = lib.licenses.mit;
    mainProgram = "aniworld";
  };
}