{ config, pkgs, ... }:

{
  programs.zsh = {
    enable                    = true;
    autosuggestion.enable     = true;
    syntaxHighlighting.enable = true;
    enableCompletion          = true;
    dotDir                    = config.home.homeDirectory;

    shellAliases = {
      ls      = "eza --icons";
      ll      = "eza -la --icons";
      lt      = "eza --tree --icons";
      cat     = "bat";
      cd      = "z";
      rebuild = "sudo nixos-rebuild switch --flake ~/.nixos";
      update  = "nix flake update ~/.nixos";
      cleanup = "sudo nix-collect-garbage -d";
      gs      = "git status";
      gp      = "git push";
      gl      = "git pull";
      ga      = "git add .";
      gc      = "git commit -m";
      ff      = "fastfetch";
      momoi   = "momoisay -f";
    };

    initContent = ''
      eval "$(zoxide init zsh)"
      eval "$(atuin init zsh)"
    '';
  };
}
