-- Performance optimizations for Neovim
-- Large file handling
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
  pattern = "*",
  callback = function()
    local file = vim.fn.expand("%")
    local file_size = vim.fn.getfsize(file)
    -- Check file size on disk
    if file_size > 500 * 1024 then -- 500 KB
      vim.opt_local.syntax = "off"
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.foldmethod = "manual"
      -- Flag for other plugins/autocmds to check if this is a large file
      vim.b.large_file = true
      vim.cmd("syntax clear")
      -- Disable git gutter for large files
      if vim.fn.exists(":GitGutterDisable") == 2 then
        vim.cmd("GitGutterDisable")
      end
    end
  end,
})

-- Also check line count after buffer is loaded
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "*",
  callback = function()
    if vim.fn.line("$") > 5000 and not vim.b.large_file then -- 5000 lines
      vim.opt_local.syntax = "off"
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.foldmethod = "manual"
      -- Flag for other plugins/autocmds to check if this is a large file
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
