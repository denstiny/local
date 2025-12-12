local autocmd = vim.api.nvim_create_autocmd

local NvimConfig = vim.api.nvim_create_augroup("NvimConfig", { clear = true })

autocmd({ "BufEnter" }, {
	group = NvimConfig,
	callback = function(args)
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
		if vim.treesitter.language.add(filetype) then
			vim.treesitter.start(args.buf)
		end
	end,
})
