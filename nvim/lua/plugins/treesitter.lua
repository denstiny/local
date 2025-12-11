return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	opts = {
		ensure_installed = {
			"vim",
			"lua",
			"vimdoc",
			"html",
			"css",
			"go"
		},
	},
	build = ':TSUpdate',
	lazy = false,
}
