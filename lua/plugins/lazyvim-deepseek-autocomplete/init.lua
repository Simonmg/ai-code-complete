local M = {}

local gemini = require("plugins.lazyvim-deepseek-autocomplete.deepseek")

local function on_text_changed(opts)
	-- ...
	vim.print(opts)
end

local function get_selected_text()
	local current_mode = vim.fn.mode()

	if not string.find(current_mode, "v") then
		vim.notify("Debes estar en modo visual para selecionar codigo.", vim.log.levels.WARN)
		return nil
	end

	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	if start_pos and end_pos then
		local start_row, start_col = start_pos[2], start_pos[3]
		local end_row, end_col = end_pos[2], end_pos[3]

		local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
		local selected_lines = {}

		for i, line in ipairs(lines) do
			if i == 1 then -- Primera línea de la selección
				table.insert(selected_lines, string.sub(line, start_col))
			elseif i == #lines then -- Última línea de la selección
				table.insert(selected_lines, string.sub(line, 1, end_col - (end_row > start_row and 1 or 0)))
			else -- Líneas intermedias completas
				table.insert(selected_lines, line)
			end
		end

		return table.concat(selected_lines, "\n")
	else
		vim.notify("No se pudo obtener la selección visual.", vim.log.levels.ERROR)
		return nil
	end
end

function send_code_to_gemini()
	local selected_code = get_selected_text()

	if not selected_code then
		return
	end

	local completion = gemini.get_completion(selected_code)

	if completion then
		vim.print(completion[1].content.parts[1].text)
	end
end

-- function M.setup(opts)
-- 	local url = opts.url
-- 	local token = opts.token
--
-- 	vim.api.nvim_create_user_command("DeekSeekComplete", function()
-- 		local selected_code = get_selected_text()
--
-- 		if not selected_code then
-- 			return
-- 		end
--
-- 		local completion = deepseek.get_completion(url, token, selected_code)
--
-- 		if completion then
-- 			vim.print(completion[1].content.parts[1].text)
-- 		end
-- 	end, {})
-- end

return {
	{ "<leader>ai", send_code_to_gemini, desc = "Consultar la IA con seleccion" },
}
