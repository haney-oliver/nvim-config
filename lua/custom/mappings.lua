local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

M.dap_ui = {
  plugin = true,
  n = {
    ["<leader>dpt"] = {
      function()
        require('dapui').toggle()
      end
    }
  }
}

M.nvim_tmux_navigation = {
  plugin = true,
  n = {
    ["<C-h>"] = {
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
      end
    },
    ["<C-j>"] = {
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateDown()
      end
    },
    ["<C-k>"] = {
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateUp()
      end
    },
    ["<C-l>"] = {
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateRight()
      end
    },
    ["<C-\\>"] = {
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateLastActive()
      end
    },
    ["<C-Space>"] = {
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateNext()
      end
    },
  }
}

-- M.conform = {
--   plugin = true,
--   n = {
--     ["<leader>cf"] = {
--       function ()
--         require("conform").format()
--       end
--     }
--   }
-- }

M.general = {
  t = {
    -- navigate within terminal mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  }
}

return M
