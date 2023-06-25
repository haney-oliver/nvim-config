return {
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      {
        "<C-h>",
        "<cmd> TmuxNavigateLeft<CR>",
        "window left",
      },
      {
        "<C-j>",
        "<cmd> TmuxNavigateDown<CR>",
        "window down",
      },
      { "<C-k>", "<cmd> TmuxNavigateUp<CR>", "window up" },
      { "C-l", "<cmd> TmuxNavigateRight<CR>", "window right" },
    },
  },
}
