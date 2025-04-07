local M = {}

M.setup = function(config)
	M.config = vim.tbl_deep_extend("force", {
		url = "",
		token = "",
	}, config or {})
end

M.get_config = function()
	return M.config
end

return M
