-- Performance optimizations and large file handling
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Performance tweaks for Treesitter
      opts.highlight = opts.highlight or {}
      opts.highlight.disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end
      return opts
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Create autocommands for large file handling
      local aug = vim.api.nvim_create_augroup("LargeFileOptimizations", { clear = true })
      
      -- Define what constitutes a "large file" (in lines)
      local large_file_threshold = 500
      local very_large_file_threshold = 5000
      
      vim.api.nvim_create_autocmd("BufReadPre", {
        group = aug,
        callback = function(args)
          local buf = args.buf
          local filename = vim.api.nvim_buf_get_name(buf)
          
          -- Check file size in bytes
          local ok, stats = pcall(vim.loop.fs_stat, filename)
          if ok and stats then
            local size_kb = stats.size / 1024
            
            -- For very large files (>500KB), disable expensive features
            if size_kb > 500 then
              vim.b[buf].large_file = true
              
              -- Disable syntax highlighting for very large files
              vim.api.nvim_buf_call(buf, function()
                vim.cmd("syntax off")
              end)
              
              -- Disable gitgutter
              vim.b[buf].gitgutter_enabled = 0
              
              -- Disable spell checking
              vim.opt_local.spell = false
              
              -- Disable folding
              vim.opt_local.foldmethod = "manual"
              vim.opt_local.foldexpr = ""
              
              -- Disable swap file for large files
              vim.opt_local.swapfile = false
              
              -- Disable undo file for very large files (>5MB)
              if size_kb > 5000 then
                vim.opt_local.undofile = false
              end
            end
          end
        end,
        desc = "Disable expensive features for large files",
      })
      
      vim.api.nvim_create_autocmd("BufRead", {
        group = aug,
        callback = function(args)
          local buf = args.buf
          local line_count = vim.api.nvim_buf_line_count(buf)
          
          -- For files with many lines
          if line_count > large_file_threshold then
            -- Increase fold level to avoid initial folding overhead
            vim.opt_local.foldlevelstart = 99
            
            -- Disable spell checking
            vim.opt_local.spell = false
          end
          
          -- For very large files by line count
          if line_count > very_large_file_threshold then
            -- Disable gitgutter
            vim.b[buf].gitgutter_enabled = 0
            
            -- Use manual folding only
            vim.opt_local.foldmethod = "manual"
          end
        end,
        desc = "Optimize settings based on line count",
      })
      
      return opts
    end,
  },
}
