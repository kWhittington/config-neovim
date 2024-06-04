return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {},
      pickers = {
        tags = {
          theme = "cursor",
          layout_config = {
            height = 10,
            preview_cutoff = 120,
            width = 0.99,
          },
        },
        find_files = {
          theme = "cursor",
          layout_config = {
            height = 10,
            preview_cutoff = 120,
            width = 0.99,
          },
        },
        grep_string = {
          theme = "cursor",
          layout_config = {
            height = 10,
            preview_cutoff = 120,
            width = 0.99,
          },
        },
        live_grep = {
          theme = "cursor",
          layout_config = {
            height = 10,
            preview_cutoff = 120,
            width = 0.99,
          },
        },
        buffers = {
          theme = "cursor",
          layout_config = {
            height = 10,
            preview_cutoff = 120,
            width = 0.99,
          },
        },
      },
    },
    keys = {
      {
        '<Leader><S-t>',
        function()
          require'telescope.builtin'.tags{}
        end,
        desc = 'Search for ctags',
        silent = true,
      },
      {
        '<Leader><S-f>',
        function()
          require'telescope.builtin'.find_files{}
        end,
        desc = 'Search for files in the working directory',
        silent = true,
      },
      {
        '<Leader><S-s>',
        function()
          require'telescope.builtin'.grep_string{}
        end,
        desc = 'Search for strings in the working directory',
        silent = true,
      },
      {
        '<Leader><S-p>',
        function()
          require'telescope.builtin'.live_grep{}
        end,
        desc = 'Live rg search for whatever you type',
        silent = true,
      },
      {
        '<Leader><S-b>',
        function()
          require'telescope.builtin'.buffers{}
        end,
        desc = 'Search for buffers',
        silent = true,
      },
    },
  },
}
