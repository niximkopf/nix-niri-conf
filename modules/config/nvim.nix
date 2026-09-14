{ pkgs, lib, ... }:

{
    programs.nvf = {
        enable = true;
        settings = {
            vim = {
                theme = {
                    enable = true;
                    name = "catppuccin";
                    style = "mocha";
                };

                languages = {
                    enableLSP = true;
                    enableTreesitter = true;

                    nix.enable = true;
                    clang.enable = true;
                    python.enable = true;
                    zsh.enable = true;
                    lua.enable = true;
                };
            
                statusline.lualine.enable = true;
                telescope.enable = true;
                autocomplete.nvim-cmp.enable = true;
            };
        };
    };
}