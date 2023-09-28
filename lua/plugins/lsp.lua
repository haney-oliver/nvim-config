return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(
        opts.ensure_installed,
        {
          "pyright",
          "angularls",
          "csharp_ls",
          "dockerls",
          "bashls",
          "gopls",
          "helm_ls",
          "json_ls",
          "sqlls",
          "terraformls",
          "tflint",
          "tsserver",
          "markdownlint",
          "prettier",
          "yamlfmt",
          "google-java-format",
          "black"
        }
      )
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "hcl",
        "terraform",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
    },
  },
}
