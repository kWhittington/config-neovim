-- Add a custom keybinding to toggle the colorscheme
vim.api.nvim_set_keymap('n', '<leader>tt', ':CyberdreamToggleMode<CR>', { noremap = true, silent = true })

return {
  {
    {
      'scottmckendry/cyberdream.nvim',
      lazy = false,
      priority = 1000,
      opts = {
      },
    },
    {
      'LazyVim/LazyVim',
      opts = {
        colorscheme = 'cyberdream',
      }
    }
  }
}
