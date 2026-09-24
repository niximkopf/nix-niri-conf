{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        Name = ""; # Replace with your actual name
        Email = ""; # Replace with your actual email
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}