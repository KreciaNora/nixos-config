{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;

    # Motyw rose-pine
    colorscheme = "rose-pine";

    # Clipboard systemowy + nvim
    clipboard = "unnamedplus";

    # Wtyczki
    plugins = with pkgs.vimPlugins; [
      rose-pine

      # Autouzupełnianie
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline

      # LSP
      nvim-lspconfig
      mason
      mason-lspconfig

      # Autozamykane nawiasy
      nvim-autopairs

      # Autozamykane tagi HTML
      nvim-ts-autotag

      # Treesitter dla HTML, CSS, JS, PHP
      nvim-treesitter
    ];

    # LSP servers
    lsp = {
      enable = true;
      servers = [ "html" "cssls" "tsserver" "phpactor" ];
    };

    # CMP autocompletion
    completion = {
      enable = true;
    };


  };
}

