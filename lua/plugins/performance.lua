-- Performance optimizations for Neovim
return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Performance settings
      vim.opt.lazyredraw = true
      vim.opt.ttyfast = true
      vim.opt.updatetime = 250
      vim.opt.timeoutlen = 500
      vim.opt.ttimeoutlen = 10
      vim.opt.synmaxcol = 200
      vim.opt.regexpengine = 1
      vim.opt.maxmempattern = 1000
      
      -- Large file handling
      vim.api.nvim_create_autocmd({ "BufReadPre" }, {
        pattern = "*",
        callback = function()
          local file_size = vim.fn.getfsize(vim.fn.expand("%"))
          if file_size > 512000 or vim.fn.line("$") > 5000 then -- 500KB or 5000 lines
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
      
      return opts
    end,
  },
}
