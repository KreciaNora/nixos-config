return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",        
        "pyright",       
        "ts_ls",         
        "html",          
        "cssls",         
        "jsonls",        
      },
      automatic_installation = true,
    })
  end,
}
