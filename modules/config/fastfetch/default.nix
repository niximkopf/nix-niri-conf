{ pkgs, lib, ... }:

let
  # Wrapper that picks a random logo from ~/.config/fastfetch/ascii/
  # on every invocation and forwards it to the real fastfetch binary.
  fastfetchRandomLogo = pkgs.writeShellScriptBin "fastfetch" ''
    ascii_dir="$HOME/.nixos/modules/config/fastfetch/ascii"
    random_logo=$(${pkgs.findutils}/bin/find "$ascii_dir" -type f | ${pkgs.coreutils}/bin/shuf -n 1)
    exec ${pkgs.fastfetch}/bin/fastfetch --logo "$random_logo" "$@"
  '';
in
{
  home.packages = [ fastfetchRandomLogo ];

  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./config.jsonc;
    "fastfetch/ascii".source = ./ascii;
  };
}
