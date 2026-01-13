-- Performance optimizations and large file handling

-- Constants for file size thresholds
local LARGE_FILE_SIZE_KB = 500        -- 500 KB
local VERY_LARGE_FILE_SIZE_KB = 5000  -- 5 MB (5000 KB)
local TREESITTER_MAX_FILESIZE = 100 * 1024 -- 100 KB in bytes
local LARGE_FILE_LINES = 500
local VERY_LARGE_FILE_LINES = 5000

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Performance tweaks for Treesitter
      opts.highlight = opts.highlight or {}
      opts.highlight.disable = function(lang, buf)
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > TREESITTER_MAX_FILESIZE then
          return true
        end
        return false
      end
      return opts
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Create autocommands for large file handling
      local aug = vim.api.nvim_create_augroup("LargeFileOptimizations", { clear = true })
      
      vim.api.nvim_create_autocmd("BufReadPre", {
        group = aug,
        callback = function(args)
          local buf = args.buf
          local filename = vim.api.nvim_buf_get_name(buf)
          
          -- Check file size in bytes
          local ok, stats = pcall(vim.loop.fs_stat, filename)
          if ok and stats then
            local size_kb = stats.size / 1024
            
            -- For very large files, disable expensive features
            if size_kb > LARGE_FILE_SIZE_KB then
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
              
              -- Disable undo file for very large files
              if size_kb > VERY_LARGE_FILE_SIZE_KB then
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
          if line_count > LARGE_FILE_LINES then
            -- Increase fold level to avoid initial folding overhead
            vim.opt_local.foldlevelstart = 99
            
            -- Disable spell checking
            vim.opt_local.spell = false
          end
          
          -- For very large files by line count
          if line_count > VERY_LARGE_FILE_LINES then
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
