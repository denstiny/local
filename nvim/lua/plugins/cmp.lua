return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-cmdline" },
		{ "onsails/lspkind-nvim" },
		{ "hrsh7th/cmp-buffer",                option = { keyword_pattern = [[\k\+]] } },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-calc" },
		--{ "dmitmel/cmp-digraphs" },
		{ "f3fora/cmp-spell" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "lukas-reineke/cmp-under-comparator" },
	},
	config = function()
		local lspkind = require("lspkind")

		lspkind.init({
			preset = "codicons",
			symbol_map = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = "",
				--cmp_tabnine = "",
				calc = " 󰃬",
				Codeium = "",
			},
		})

		require("cmp_nvim_lsp")
		require("cmp_path")
		require("cmp_buffer")
		local snip = require("luasnip")
		local cmp = require "cmp"

		local opt = {
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					snip.lsp_expand(args.body)
				end,
			},
			experimental = { ghost_text = true },
			window = {
				completion = {
					--border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
					border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
					--border = { "┌", " ", "┐", "│", "┘", " ", "└", "│" },
					winhighlight = "FloatBorder:FloatBorder,CursorLine:CursorLine",
				},
				documentation = {
					max_width = 50,
					--border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					border = { "┌", " ", "┐", "│", "┘", " ", "└", "│" },
					winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				},
			},
			mapping = {
				-- ["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.get_selected_entry() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end, { "i", "c" }),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.close(),
				["<C-l>"] = cmp.mapping.confirm({
					select = true,
					behavior = cmp.ConfirmBehavior.Replace,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-j>"] = cmp.mapping(function(fallback)
					if require("neogen").jumpable(-1) then
						require("neogen").jump_next()
					elseif require("luasnip").jumpable(1) then
						require("luasnip").jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-k>"] = cmp.mapping(function(fallback)
					if require("neogen").jumpable(1) then
						require("neogen").jump_prev()
					elseif require("luasnip").jumpable(-1) then
						require("luasnip").jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			sources = {
				{ name = "nvim_lsp", priority = 8 },
				{ name = "lazydev" },
				-- { name = "neorg", priority = 10 },
				{ name = "luasnip",  priority = 8, options = { use_show_condition = false } },
				{ name = "nvim_lua" },
				{ name = "buffer",   priority = 7 },
				{ name = "path",     priority = 7 },
				{ name = "calc",     priority = 6 },
				--{ name = "cmp_tabnine", priority = 6 },
				--{ name = "digraphs", priority = 5 },
				{ name = "spell",    priority = 5 },
			},
			preselect = cmp.PreselectMode.None,
			sorting = {
				comparators = {
					require("cmp-under-comparator").under,
					cmp.config.compare.score,
					cmp.config.compare.exact,
					cmp.config.compare.locality,
					cmp.config.compare.recently_used,
					cmp.config.compare.order,
					cmp.config.compare.offset,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					--cmp.config.compare.length,
				},
			},
		}
		cmp.setup(opt)
	end,
}
