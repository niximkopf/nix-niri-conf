{ ... }:

{
   programs.kitty = {
      enable = true;
      #themeFile = "Duotone_Dark";
      settings = {
         cursor_trail = 1;
         cursor_trail_start_threshold = 1;
         cursor_trail_color = "#cba6f7";
         cursor_shape = "beam";
         confirm_os_window_close = 0;
         enable_audio_bell = false;
         background_opacity = "0.5";
         background_blur = 1;
      };
      font = {
         size = 14;
         name = "Monocraft"; #JetBrainsMono Nerd Font
      };
      extraConfig = ''
         include ~/.config/kitty/themes/noctalia.conf
      '';
   };
}
