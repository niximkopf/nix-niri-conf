{ pkgs, lib, ... }:

let
  # Cycles through logos in ~/.config/fastfetch/ascii/ in alphabetical
  # order on every invocation, remembering position in a state file.
  fastfetchRandomLogo = pkgs.writeShellScriptBin "fastfetch" ''
    ascii_dir="$HOME/.config/fastfetch/ascii"
    state_file="$HOME/.cache/fastfetch-logo-index"
    mkdir -p "$(dirname "$state_file")"

    mapfile -t logos < <(${pkgs.findutils}/bin/find -L "$ascii_dir" -type f | ${pkgs.coreutils}/bin/sort)
    count=''${#logos[@]}

    if [ -f "$state_file" ]; then
      idx=$(${pkgs.coreutils}/bin/cat "$state_file")
    else
      idx=-1
    fi
    idx=$(( (idx + 1) % count ))
    echo "$idx" > "$state_file"

    exec ${pkgs.fastfetch}/bin/fastfetch --logo "''${logos[$idx]}" "$@"
  '';
in
{
  home.packages = [ fastfetchRandomLogo ];

  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./config.jsonc;
    "fastfetch/ascii".source = ./ascii;
  };
}