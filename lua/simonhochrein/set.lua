-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.g.neoformat_try_node_exe = 1

vim.g.python3_host_prog = "C:/Users/simon/AppData/Local/Microsoft/WindowsApps/python.exe"

-- augroup fmt
-- autocmd!
--   autocmd BufWritePre * undojoin | Neoformat
-- augroup END
vim.api.nvim_create_augroup("fmt", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "undojoin | Neoformat",
})

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    if require("nvim-treesitter.parsers").has_parser() then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    else
      vim.opt.foldmethod = "syntax"
    end
  end,
})

vim.filetype.add({
  extension = {
    tf = "terraform"
  }
})
