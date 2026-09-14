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
                    transparent = true;
                };

                options = {
                    tabstop = 3;
                    shiftwidth = 3;
                    expandtab = true;
                };

                maps.normal."<C-b>" = {
                    action = "<cmd>Neotree toggle<cr>";
                    desc = "Toggle file explorer";
                };

                lsp.enable = true;

                languages = {
                    enableTreesitter = true;

                    nix.enable = true;
                    clang.enable = true;
                    python.enable = true;
                    zsh.enable = true;
                    lua.enable = true;
                };

                filetree.neo-tree = {
                        enable = true;
                        setupOpts.window.position = "right";
                };

                tabline.nvimBufferline.enable = true;

                git = {
                    enable = true;
                    gitsigns.enable = true;
                };

                terminal.toggleterm.enable = true;

                debugger.nvim-dap = {
                    enable = true;
                    ui.enable = true;
                };

                binds.whichKey.enable = true;
            
                statusline.lualine.enable = true;
                telescope.enable = true;
                autocomplete.nvim-cmp.enable = true;
            };
        };
    };
}
