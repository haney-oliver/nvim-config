local config = require "plugins.configs.lspconfig"

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require "lspconfig"

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "bash", "sh" },
}

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "terraform", "terraform-vars", "hcl", "tf" },
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    gopls = {
      gofumpt = true,
      experimentalPostfixCompletions = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
}

lspconfig.golangcilsp = {
  default_config = {
    cmd = { "golangci-lint-langserver" },
    root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
    init_options = {
      command = { "golangci-lint", "run", "--out-format", "json" },
    },
  },
}


