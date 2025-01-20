require("neo-tree").setup {
  sources = {
    "filesystem",
    "buffers",
    "git_status",
    "document_symbols"
  }
}

vim.keymap.set("n", "<leader>pv", function()
  vim.cmd([[:Neotree toggle<cr>]])
end)
vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
