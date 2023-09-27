local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-treesitter/playground" },
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },

	--- Uncomment these if you want to manage LSP servers from neovim
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- LSP Support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
	},
	"numToStr/Comment.nvim",
	"sbdchd/neoformat",
	"startup-nvim/startup.nvim",
})

require("rose-pine").setup({
	disable_background = true,
	disable_float_background = true,
})

vim.cmd("colorscheme rose-pine")
