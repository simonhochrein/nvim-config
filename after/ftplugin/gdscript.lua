local port = os.getenv("GDScript_Port") or "6005"
local cmd = { "ncat", "127.0.0.1", port }
local pipe = [[\\.\pipe\godot.pipe]]

vim.lsp.start({
	name = "Godot",
	cmd = cmd,
	root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
	on_attach = function(client, bufnr)
		-- vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
    vim.fn.serverstart(pipe)
	end,
})


-- local lspconfig = require('lspconfig')
-- lspconfig.gdscript.setup {}
--
-- local path = "\\\\.\\pipe\\godot.pipe"
-- if not vim.loop.fs_stat(path) then
--   vim.fn.serverstart(path)
-- end
