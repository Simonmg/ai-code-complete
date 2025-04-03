local deepseek = require("plugins.lazyvim-deepseek-autocomplete.deepseek")
local config = require("plugins.lazyvim-deepseek-autocomplete.config")

local M = {}

function M.setup(opts)
	vim.api.nvim_create_user_command("DeepseekHolla", function()
		vim.cmd('echo "plugin cargado con nvim"')
	end, {})
end

return M
