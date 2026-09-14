{ ... }:

{
   programs.kitty = {
      enable = true;
      settings = {
         cursor_trail = 1;
         cursor_trail_decay = 0.1 0.4;
         confirm_os_window_close = 0;
         enable_audio_bell = false;
         background_opacity = "0.6";
         background_blur = 1;
         font = {
            size = 13;
            normal.family = "JetBrainsMono Nerd Font";
         };
      };
   };
}
