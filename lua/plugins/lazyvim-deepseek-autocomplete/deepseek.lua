local curl = require("plenary.curl")

local M = {}

local function send_request(url, token, promt)
	local headers = {
		["Authorization"] = "Bearer" .. token,
		["Content-Type"] = "application/json",
	}

	local body = vim.json.encode({ promt = promt })

	local response = curl.post(url, {
		body = body,
		headers = headers,
	})

	print(response)

	return vim.json.decode(response)
end

function M.get_completion(config, promt)
	local url = config.url
	local token = config.token

	if not url or not token then
		vim.notify("DeepSeek: Url o token no configurados", vim.log.levels.ERROR)
		return nil
	end

	print(url, token)

	local response = send_request(url, token, promt)

	if response and response.choises and response.choises[1] then
		return response.choises[1].text
	else
		vim.notify("DeepSeek: No se pudo obtener la completion", vim.log.levels.ERROR)
		return nil
	end
end

return M
