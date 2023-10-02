local function pull_config()
	local initial_dir = vim.fn.getcwd()
	local config_dir = vim.fn.stdpath("config")
	vim.fn.chdir(config_dir)
	vim.api.nvim_out_write(vim.fn.system("git pull"))
	vim.fn.chdir(initial_dir)
end

vim.api.nvim_create_user_command("PullConfig", pull_config, { nargs = "?" })

return {
	pull_config,
}
