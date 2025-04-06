local http = require("plenary.curl")
local config = require("plugins.lazyvim-deepseek-autocomplete.config")
local M = {}

local function send_request(promp)
	local url = config.url
	local token = config.token

	local headers = {
		["Content-Type"] = "application/json",
	}

	local timeout_ms = 30000

	local post_data = {
		contents = {
			{
				parts = {
					text = string.format(
						"Dame sugerencias para la siguiente línea de código:\n```lua\n%s\n```\nConsidera posibles mejoras, errores comunes o alternativas.",
						promp
					),
				},
			},
		},
	}

	local body = vim.json.encode(post_data)

	local response = http.post(url .. token, {
		headers = headers,
		body = body,
		timeout_ms = timeout_ms,
	})

	return vim.json.decode(response.body)
end

function M.get_completion(url, token, promp)
	if not url or not token then
		vim.notify("DeepSeek: Url o token no configurados", vim.log.levels.ERROR)
		return nil
	end

	local response = send_request(url, token, promp)

	if response and response.candidates then
		return response.candidates
	else
		vim.notify("Gemini: No se pudo obtener la completion", vim.log.levels.ERROR)
		return nil
	end
end

return M
