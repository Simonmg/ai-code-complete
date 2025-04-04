local curl = require("plenary.curl")

local M = {}

local function send_request(url, token, promp)
	local headers = {
		["Content-Type"] = "application/json",
	}

	vim.notify("Enviando solicitud...", "info", { title = "deepseek-chat" })

	local post_data = {
		contents = {
			{
				parts = {
					text = promp,
				},
			},
		},
	}

	local body = vim.json.encode(post_data)

	local response = curl.post(url .. token, {
		headers = headers,
		body = body,
	})

	print(vim.json.decode(response))

	-- return vim.json.decode(response)
end

function M.get_completion(url, token, promp)
	if not url or not token then
		vim.notify("DeepSeek: Url o token no configurados", vim.log.levels.ERROR)
		return nil
	end

	local response = send_request(url, token, promp)

	if response and response.choises and response.choises[1] then
		return response.choises[1].text
	else
		vim.notify("DeepSeek: No se pudo obtener la completion", vim.log.levels.ERROR)
		return nil
	end
end

return M
