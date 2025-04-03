local function show_hello_world()
	local content = "Hola Mundo"
	local width = vim.api.nvim_strwidth(content) + 2
	local height = 3

	local opts = {
		relative = "cursor",
		row = 1,
		col = 0,
		width = width,
		height = height,
		border = "rounded",
		title = "Saludo",
		focusable = false,
	}

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { content })

	vim.api.nvim_open_win(buf, false, opts)
end

return {
	{
		cmd = "DeepSeekHello", -- Cambiamos el nombre del comando para evitar confusiones
		callback = show_hello_world,
		desc = "Muestra Hola Mundo en una ventana flotante",
	},
}
