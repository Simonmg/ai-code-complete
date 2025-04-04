local curl = require("plenary.curl")

local M = {}

local function send_request(url, token, promp)
	print(url, token, promp)
	local headers = {
		["Authorization"] = "Bearer" .. token,
		["Content-Type"] = "application/json",
	}

	local body = vim.json.encode({ promt = promt })

	local response = curl.post(url, {
		body = body,
		headers = headers,
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
