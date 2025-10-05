return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      
      columns = {
        "icon",
      },
      
      view_options = {
        show_hidden = true, 
      },
      
      delete_to_trash = false,
      
      skip_confirm_for_simple_edits = false,

       
      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
        
      },
    })

    vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open oil in floating window" })
  end,
}

