local deepseek = require("plugins.lazyvim-deepseek-autocomplete.deepseek")
local config = require("plugins.lazyvim-deepseek-autocomplete.config")

local win_id = nil -- ID de la ventana flotante

local function close_popup()
	if win_id then
		vim.api.nvim_win_close(win_id, true)
		win_id = nil
	end
end

local function show_popup(content)
	close_popup() -- Cerrar la ventana anterior si existe

	local width = vim.api.nvim_strwidth(content) + 2
	local height = 3

	local border = "rounded"

	local opts = {
		relative = "cursor",
		row = 1,
		col = 0,
		width = width,
		height = height,
		border = border,
		title = "DeepSeek",
		focusable = false,
	}

	win_id = vim.api.nvim_open_win(vim.api.nvim_create_buf("", false), false, opts)

	vim.api.nvim_buf_set_lines(vim.api.nvim_win_get_buf(win_id), 0, -1, false, { content })
end

local function on_text_changed()
	local current_line = vim.api.nvim_get_current_line()
	local completion = deepseek.get_completion(config.get_config(), current_line)

	if completion then
		show_popup(completion)
	else
		close_popup()
	end
end

return {
	config = config.setup,
	{
		cmd = "DeepSeekComplete",
		callback = function()
			local current_line = vim.api.nvim_get_current_line()
			local autocomplete = deepseek.get_completion(config.get_config, current_line)

			print(autocomplete)

			if autocomplete then
				vim.api.nvim_feedkeys(completion, "n", false)
			end
		end,
		desc = "Obtiene sugerencias de deepseek",
	},
	{
		event = "TextChangedI",
		callback = on_text_changed,
	},
}
