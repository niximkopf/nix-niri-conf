{ ... }:

{
   programs.kitty = {
      enable = true;
      settings = {
         cursor_trail = 1;
         confirm_os_window_close = 0;
         enable_audio_bell = false;
         background_opacity = "0.6";
         background_blur = 5;
      };
      font = {
         size = 13;
         name = "JetBrainsMono Nerd Font";
      };
      extraConfig = ''
         "~/.config/kitty/themes/noctalia.toml" 
      '';
   };
}
