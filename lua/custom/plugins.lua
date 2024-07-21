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
        "yaml-language-server",
        "yamlfmt",
        "circleci-yaml-language-server",
        "gopls",
        "golangci-lint",
        "golangci-lint-langserver",
        "stylua",
      },
    },
  },
  -- {
  --   "christoomey/vim-tmux-navigator",
  --   lazy = false,
  --   cmd = {
  --     "TmuxNavigateLeft",
  --     "TmuxNavigateDown",
  --     "TmuxNavigateUp",
  --     "TmuxNavigateRight",
  --     "TmuxNavigatePrevious",
  --   },
  --   keys = {
  --     { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
  --     { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
  --     { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
  --     { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
  --     { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  --   },
  -- }
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    ensure_installed = {
      "circleci-yaml-language-server",
      "terraform-ls",
    },
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
    opts = { ensure_installed = { "markdown", "markdown_inline", "python", "terraform", "hcl", "go" } },
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
      require("conform").setup {
        -- format_on_save = function(bufnr)
        --   if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        --     return
        --   end
        --   return { timeout_ms = 2999, lsp_fallback = true }
        -- end,
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          terraform = { "terragrunt_hclfmt" },
          tf = { "terragrunt_hclfmt" },
          hcl = { "terragrunt_hclfmt" },
          yaml = { "yamlfmt" },
        },
        formattters = {
          black = {
            command = "/Users/ohaney/.pyenv/shims/black",
            args = { "--line-length", "88", "--preview" },
          },
        },
      }
    end,
  },
}

return plugins
