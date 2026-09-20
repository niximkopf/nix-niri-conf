{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        Name = "niximkopf"; # Replace with your actual name
        Email = "niximkopf@proton.me"; # Replace with your actual email
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}