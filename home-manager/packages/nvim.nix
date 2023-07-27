{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter # syntax for everything      
      telescope-nvim # Fuzzy finder
      nvim-autopairs # Automatic brackets
      nvim-tree-lua # Tree view
    ];
    extraConfig = ''
      set autoindent expandtab tabstop=2 shiftwidth=2

      nnoremap <leader>p :Telescope find_files hidden=true <cr>
      nnoremap <leader>t :NvimTreeToggle <cr>
      nnoremap <leader>T :NvimTreeFindFile <cr>
    '';
    extraLuaConfig = ''
      -- Setup nvim-tree-lua
      require("nvim-tree").setup({
      })
    '';
  };
}
