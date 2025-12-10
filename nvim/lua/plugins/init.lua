return {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },

 {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
  {
    "glepnir/lspsaga.nvim",
  },
  {
    "mbbill/undotree",
		config = function()
			vim.g.undotree_SetFocusWhenToggle = 1
		end
  },

}
