local deepseek = require("plugins.lazyvim-deepseek-autocomplete.deepseek")
local config = require("plugins.lazyvim-deepseek-autocomplete.config")

return {
	config = config.setup,
	{
		cmd = "DeepSeekComplete",
		callback = function()
			local current_line = vim.api.nvim_get_current_line()
			local autocomplete = deepseek.get_completion(config.get_config, current_line)

			if autocomplete then
				vim.api.nvim_feedkeys(completion, "n", false)
			end
		end,
		desc = "Obtiene sugerencias de deepseek",
	},
}
