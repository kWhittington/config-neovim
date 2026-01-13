return {
  {
    "airblade/vim-gitgutter",
    init = function()
      -- Performance optimizations for vim-gitgutter
      vim.g.gitgutter_max_signs = 500
      vim.g.gitgutter_realtime = 0
      vim.g.gitgutter_eager = 0
    end,
  },
}
