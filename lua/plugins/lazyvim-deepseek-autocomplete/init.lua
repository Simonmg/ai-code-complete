-- ~/.config/nvim/lua/plugins/deepseek_complete/init.lua

local deepseek = require("plugins.deepseek_complete.deepseek")
local config = require("plugins.deepseek_complete.config")

local function on_text_changed(opts)
	-- ...
	vim.print(opts)
end

return {
	config = config.setup, -- Esta línea es importante para que LazyVim ejecute config.setup
	{
		cmd = "DeepSeekComplete",
		callback = function()
			local current_line = vim.api.nvim_get_current_line()
			local completion = deepseek.get_completion(config.get_config(), current_line)

			on_text_changed("hola mundo")
			if completion then
				-- mostrar el popup
			end
		end,
		desc = "Obtiene sugerencias de DeepSeek",
	},
	{
		event = "TextChangedI",
		callback = on_text_changed,
	},
}
