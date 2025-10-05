return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,  -- Ładuj jako pierwszy
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",  -- latte, frappe, macchiato, mocha
      transparent_background = true,
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
