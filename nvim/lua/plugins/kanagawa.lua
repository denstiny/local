return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	priority = 1000,
	cond = false,
	config = function()
		vim.cmd([[ colorscheme kanagawa-dragon ]])
	end,
}
