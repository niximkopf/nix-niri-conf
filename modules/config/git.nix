{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        Name = "niximkopf"; # Replace with your actual name
        Email = "michi.dyck06@gmail.com"; # Replace with your actual email
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "nvim";
    };
  };
}