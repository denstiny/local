return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local opts = {
			indent = { enable = true },
			highlight = { enable = true, use_languagetree = true },
			folds = { enable = true },
			install = { "lua", "luadoc", "vim", "vimdoc", "go", "python", "rust" },
		}
		require("nvim-treesitter").setup(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = opts.install,
			callback = function(args)
				pcall(function()
					vim.treesitter.start()
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldmethod = "expr"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end)
			end,
		})
	end,
}
