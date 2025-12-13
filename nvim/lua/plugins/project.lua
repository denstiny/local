return {
	"DrKJeff16/project.nvim",
	cmd = { -- Lazy-load by commands
		"Project",
		"ProjectAdd",
		"ProjectConfig",
		"ProjectDelete",
		"ProjectHistory",
		"ProjectRecents",
		"ProjectRoot",
		"ProjectSession",
		"ProjectTelescope",
	},
	dependencies = { -- OPTIONAL
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"ibhagwan/fzf-lua",
	},
	config = function()
		require("project_nvim").setup({
			patterns = { ---@type string[]
				".git",
				".github",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Pipfile",
				"pyproject.toml",
				".pre-commit-config.yaml",
				".pre-commit-config.yml",
				".csproj",
				".sln",
				".nvim.lua",
				"go.mod",
				"MakeFile",
			},
		})
	end,
}
