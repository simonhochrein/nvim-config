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
vim.o.guifont = "FiraCode Nerd Font Mono"

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1"

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- vim.api.nvim_create_autocmd({"FileType"}, {
--     callback = function()
--         if require("nvim-treesitter.parsers").has_parser() then
--             vim.opt.foldmethod = "expr"
--             vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--         else
--             vim.opt.foldmethod = "syntax"
--         end
--     end
-- })

vim.filetype.add({ extension = { tf = "terraform", templ = "templ", vert = "glsl", frag = "glsl" } })

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

if vim.fn.has('win32') then
  vim.g.undotree_DiffCommand = "FC"
  vim.g.python3_host_prog = "C:/Users/simon/AppData/Local/Microsoft/WindowsApps/python.exe"
end
if vim.fn.has('osx') then
  --TODO: add python path
end

vim.g.neovide_transparency = 0.8
vim.g.neovide_normal_opacity = 0.8
