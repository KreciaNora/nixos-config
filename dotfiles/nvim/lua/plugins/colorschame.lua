return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,  
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",  -- latte, frappe, macchiato, mocha
      transparent_background = false,
      solid = true,
      integrations = {
        treesitter = true,
        telescope = true,
        nvimtree = true,
      },
    })
    
    -- Ustaw motyw
    vim.cmd.colorscheme("catppuccin")
  end,
}
