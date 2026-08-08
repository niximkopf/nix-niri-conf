{ ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        size = 13;
        normal.family = "JetBrainsMono Nerd Font";
      };

      window.opacity = 0.85; # entspricht background_opacity = "0.85"

      bell.duration = 0; # entspricht enable_audio_bell = false

      # Von Noctalia generiertes Theme einbinden (analog zu
      # "include themes/noctalia.conf" in kitty.nix)
      general.import = [ "~/.config/alacritty/themes/noctalia.toml" ];
    };
  };
}
