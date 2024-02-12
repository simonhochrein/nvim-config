local builtin = require("statuscol.builtin")

require("statuscol").setup({
	relculright = true,
	segments = {
		{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
		{
			sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
			click = "v:lua.ScSa",
		},
		{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
		{
			sign = { namespace = { "gitsigns" }, name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true },
			click = "v:lua.ScSa",
		},
		{ text = { " " }, colwidth = 1 },
	},
})

vim.fn.sign_define("DiagnosticSignError", { text = "󰅙", texthl = "DiagnosticError" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticWarn" })
