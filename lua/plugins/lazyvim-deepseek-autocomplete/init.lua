local M = {}

local deepseek = require("plugins.lazyvim-deepseek-autocomplete.deepseek")

local function on_text_changed(opts)
	-- ...
	vim.print(opts)
end

function M.setup(opts)
	vim.api.nvim_create_user_command("DeelSeekComplete", function()
		local current_line = vim.api.nvim_get_current_line()
		local completion = deepseek.get_completion(opts, current_line)

		if completion then
			vim.print(completion)
		end
	end, {})
end

return M
