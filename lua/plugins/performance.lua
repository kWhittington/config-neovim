-- Performance optimizations for Neovim
-- Large file handling
vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  pattern = "*",
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand("%"))
    if file_size > 500 * 1024 or vim.fn.line("$") > 5000 then -- 500 KB or 5000 lines
      vim.opt_local.syntax = "off"
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.foldmethod = "manual"
      vim.b.large_file = true
      vim.cmd("syntax clear")
      -- Disable git gutter for large files
      if vim.fn.exists(":GitGutterDisable") == 2 then
        vim.cmd("GitGutterDisable")
      end
    end
  end,
})

return {}

