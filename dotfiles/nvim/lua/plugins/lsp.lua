return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "nvim-lua/plenary.nvim", 
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local keymap = vim.keymap.set

      opts.desc = "Pokaż dokumentację"
      keymap("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Idź do definicji"
      keymap("n", "gd", vim.lsp.buf.definition, opts)

      opts.desc = "Pokaż deklarację"
      keymap("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Pokaż implementacje"
      keymap("n", "gi", vim.lsp.buf.implementation, opts)

      opts.desc = "Pokaż referencje"
      keymap("n", "gr", vim.lsp.buf.references, opts)

      opts.desc = "Dostępne akcje kodu"
      keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Zmień nazwę"
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Pokaż diagnostykę bufora"
      keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      opts.desc = "Pokaż diagnostykę linii"
      keymap("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Poprzednia diagnostyka"
      keymap("n", "[d", vim.diagnostic.goto_prev, opts)

      opts.desc = "Następna diagnostyka"
      keymap("n", "]d", vim.diagnostic.goto_next, opts)

      opts.desc = "Restart LSP"
      keymap("n", "<leader>rs", ":LspRestart<CR>", opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    
    vim.lsp.config.lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luacheckrc", ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    }

    vim.lsp.config.pyright = {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml", "setup.py", ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    vim.lsp.config.ts_ls = {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "php" },
      root_markers = { "package.json", "tsconfig.json", ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    vim.lsp.config.html = {
      cmd = { "vscode-html-language-server", "--stdio" },
      filetypes = { "html", "php" },
      root_markers = { ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    vim.lsp.config.cssls = {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css", "scss", "less" },
      root_markers = { ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    vim.lsp.config.jsonls = {
      cmd = { "vscode-json-language-server", "--stdio" },
      filetypes = { "json", "jsonc" },
      root_markers = { ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
    }
    vim.lsp.config.intelephense = {
      cmd = {"intelephense", "--stdio"},
      filetypes = {"php"},
      root_markers = {"composer.json", ".git"},
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        intelephense = {
          files = {
            maxSize = 1000000,
          },
        },
      },
    }
    vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "html", "cssls", "jsonls", "intelephense" })
  end,
}
