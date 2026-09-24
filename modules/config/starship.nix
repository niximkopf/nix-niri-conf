{ config, pkgs, lib, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = lib.concatStrings [
        "[ ┌](color_purple)"
        "[](color_bg2)"
        "$os"
        "[](bg:color_aqua fg:color_bg2)"
        "$directory"
        "[](fg:color_aqua bg:color_green)"
        "$git_branch"
        "$git_status"
        "[](fg:color_green bg:color_blue)"
        "$cmd_duration"
        "[](fg:color_blue bg:color_purple)"
        "$time"
        "[](fg:color_purple)"
        "$line_break"
        "[ └─](color_purple)"
        "$character"
      ];

      palette = "tokyo_night";
      palettes.tokyo_night = {
        color_fg_light = "#b58fff";   # For dark backgrounds
        color_fg_dark  = "#4c3a70";   # For light backgrounds

        color_red    = "#f07aac";
        color_orange = "#f5c97a";
        color_yellow = "#f5c97a";
        color_green  = "#b57bee";
        color_aqua   = "#9b59d6";
        color_blue   = "#d4a5f5";
        color_purple = "#7c6db5";

        color_bg1    = "#0e0b14";
        color_bg2    = "#1a1525";
        color_bg3    = "#3d3255";
      };

      os = {
        disabled = false;
        style = "bg:color_bg2 bold fg:color_fg_light";
        symbols = {
          NixOS = " ";
        };
      };

      directory = {
        style = "bold fg:color_bg2 bg:color_aqua";
        format = "[ $path ]($style)";
        truncation_length = 3;
      };

      git_branch = {
        symbol = "";
        style = "bg:color_green";
        format = "[[ $symbol $branch ](bold fg:color_fg_dark bg:color_green)]($style)";
      };

      git_status = {
        style = "bg:color_green bold fg:color_fg_dark";
        format = "[$all_status$ahead_behind]($style)";
      };

      cmd_duration = {
        format = "[ 󰔛 $duration ]($style)";
        disabled = false;
        style = "bg:color_blue bold fg:color_fg_dark";
        show_notifications = false;
        min_time_to_notify = 60000;
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_purple";
        format = "[[   $time ](bold fg:color_bg2 bg:color_purple)]($style)";
      };

      nix_shell = {
        format = "[ via nix $name ]($style)";
        style = "bg:color_aqua bold fg:color_fg_dark";
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:color_purple)";
        error_symbol = "[❯](bold fg:color_aqua)";
      };
    };
  };
}