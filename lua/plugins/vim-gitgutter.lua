return {
  {
    "airblade/vim-gitgutter",
    init = function()
      -- Performance optimizations for vim-gitgutter
      vim.g.gitgutter_max_signs = 500  -- Limit number of signs
      vim.g.gitgutter_realtime = 0     -- Disable realtime updates
      vim.g.gitgutter_eager = 0        -- Disable eager loading
    end,
  },
}
