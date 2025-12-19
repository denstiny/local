-- lua/plugins/rose-pine.lua
return {
	"rose-pine/neovim",
	name = "rose-pine",
	cond = false,
	config = function()
		vim.cmd("colorscheme rose-pine")
	end,
}
