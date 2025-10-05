return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- ikony
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,

      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
        },
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "󰁕",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },

      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_default",
      },

      buffers = {
        follow_current_file = { enabled = true },
      },

      git_status = {
        window = { position = "float" },
      },
    })

    -- 🔧 Klawisze skrótów
    vim.keymap.set('n', '<leader>e', ':Neotree toggle filesystem left<CR>', { desc = "Explorer (Neo-tree)" })
    vim.keymap.set('n', '<leader>b', ':Neotree toggle buffers left<CR>', { desc = "Buffers list" })
    vim.keymap.set('n', '<leader>g', ':Neotree toggle git_status float<CR>', { desc = "Git status" })
  end,
}

