{ ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        size = 13;
        normal.family = "JetBrainsMono Nerd Font";
      };

      window.opacity = 0.6;

      bell.duration = 0;

      general.import = [ "~/.config/alacritty/themes/noctalia.toml" ];
    };
  };
}
