local curl = require("plenary.curl")

local M = {}

local function send_request(url, token, promp)
	print(url, token, promp)
	local headers = {
		["Content-Type"] = "application/json",
		["Authorization"] = "Bearer " .. token,
	}

	vim.notify("Enviando solicitud...", "info", { title = "deepseek-chat" })

	local body = vim.json.encode({
		model = "deepseek-chat",
		messages = {
			{ role = "system", content = promp },
		},
		max_tokens = 1000,
		temperature = 0.0,
		stream = false,
	})

	local response = curl.post(url, {
		body = body,
		headers = headers,
		timeout = 15000,
		async = true,
		stream = false,
	})

	print(vim.inspect(response))

	-- if response and response.body then
	-- 	local data = json.decode(response.body)
	-- 	print(vim.inspect(data))
	-- else
	-- 	print("Error en la solicitud")
	-- end

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
