return {
	"glepnir/lspsaga.nvim",
	Event = "LspAction",
	config = function()
		require("lspsaga").setup({
			finder = {
				max_height = 0.6,
				keys = {
					toggle_or_open = "<cr>",
					quit = "<esc>",
				},
			},
			symbols_in_winbar = {
				enable = true,
				sign = true,
				virtual_text = true,
				priority = 100,
			},
			lightbulb = {
				enable = true,
				sign = false,
				debounce = 10,
				sign_priority = 40,
				virtual_text = true,
				enable_in_insert = true,
				ignore = {
					clients = {},
					ft = {},
				},
			},
		})
	end,
}
