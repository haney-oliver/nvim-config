local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "debugpy",
        "lua-language-server",
        "bash-language-server",
        "black",
        "grammarly-languageserver",
        "omnisharp",
        "terraform-ls",
        "gopls",
        "golangci-lint",
        "golangci-lint-langserver",
        "tailwindcss-language-server",
        "stylua",
        "isort",
        "prettier",
        "typescript-language-server",
      },
    },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    lazy = false,
    config = function()
      local nvim_tmux_nav = require "nvim-tmux-navigation"

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }
      vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    ensure_installed = {
      "pyright",
      "bashls",
      "terraformls",
      "tsserver",
    },
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
    opts = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_)
      require("core.utils").load_mappings "dap"
    end,
  },
  { "nvim-neotest/nvim-nio" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      require("core.utils").load_mappings "dap_ui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_initialized["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings "dap_python"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
        ignore = false,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "python",
        "terraform",
        "hcl",
        "go",
        "tsx",
        "toml",
        "json",
        "lua",
        "css",
        "yaml",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {},
    config = function()
      local conform = require "conform"
      conform.setup {
        -- format_on_save = function(bufnr)
        --   if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        --     return
        --   end
        --   return { timeout_ms = 2999, lsp_fallback = true }
        -- end,
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          terraform = { "terragrunt_hclfmt" },
          tf = { "terragrunt_hclfmt" },
          hcl = { "terragrunt_hclfmt" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
        },
        formattters = {
          black = {
            command = "/Users/ohaney/.pyenv/shims/black",
            args = { "--line-length", "88", "--preview" },
          },
        },
      }
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    lazy = false,
    main = "render-markdown",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
}

return plugins
