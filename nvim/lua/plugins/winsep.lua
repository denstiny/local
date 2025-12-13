return {
	"nvim-zh/colorful-winsep.nvim",
	event = { "WinLeave" },
	opts = {
		border = { "─", "│", "┌", "┐", "└", "┘" },
		animate = {
			enabled = false,
		},
		indicator_for_2wins = {
			position = "false", -- false to disable or choose between "center", "start", "end" and "both"
		},
	},
}
