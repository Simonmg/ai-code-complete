local M = {}

local function send_request(url, token, promt)
	local headers = {
		["Authorization"] = "Bearer" .. token,
		["ContentType"] = "application/json",
	}

	local body = vim.json.encode({ promt = promt })

	local response = vim.fn.curl_easy({
		url = url,
		method = "POST",
		postfields = body,
		httpheader = headers,
	})

	return vim.json.decode(response)
end

function M.get_completion(config, promt)
	local url = config.url
	local token = config.token

	if not url or not token then
		vim.notify("DeepSeek: Url o token no configurados", vim.log.levels.ERROR)
		return nil
	end

	local response = send_request(url, token, promt)

	if response and response.choises and response.choises[1] then
		return response.choises[1].text
	else
		vim.notify("DeepSeek: No se pudo obtener la completion", vim.log.levels.ERROR)
		return nil
	end
end

return M
