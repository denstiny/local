return {
	"ggandor/leap.nvim",
	opts = {},
	lazy = false,
	config = function()
		local leap = require("leap")
		vim.keymap.set("n", "s", function()
			require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
		end)
	end,
}
