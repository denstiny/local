return {
	"nvim-zh/colorful-winsep.nvim",
	event = { "WinLeave" },
	config = function()
		require("colorful-winsep").setup({
			border = { "─", "│", "┌", "┐", "└", "┘" },
			animate = {
				enabled = false,
			},
			indicator_for_2wins = {
				position = "false", -- false to disable or choose between "center", "start", "end" and "both"
			},
		})

		vim.cmd([[ hi ColorfulWinSep guifg=#8A9A7B ]])
	end,
}
