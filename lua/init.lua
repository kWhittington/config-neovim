-- install lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Performance optimizations
require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim" },
		{ import = "plugins" },
	},
	-- Performance defaults for lazy.nvim
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- we're only using python NeoVim
vim.g.python3_host_prog = vim.fn.expand('~/.pyenv/versions/pynvim/bin/python')
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Additional performance options in Lua
vim.opt.lazyredraw = true       -- Don't redraw screen during macros
vim.opt.ttyfast = true           -- Faster terminal
vim.opt.updatetime = 250         -- Faster CursorHold
vim.opt.timeoutlen = 500         -- Faster key sequences
vim.opt.ttimeoutlen = 10         -- Faster key codes
vim.opt.regexpengine = 1         -- Faster regex engine
vim.opt.synmaxcol = 200          -- Limit syntax highlighting columns
vim.opt.maxmempattern = 1000     -- Limit pattern matching memory
