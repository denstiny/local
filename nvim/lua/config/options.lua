local o = vim.o
o.showmode = false
o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.ignorecase = true
o.smartcase = true
o.number = true
o.numberwidth = 1
o.ruler = false
o.viewoptions = "folds,cursor"
o.sessionoptions = "curdir,winsize,blank,terminal"
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 400
o.updatetime = 250
o.cursorline = false
o.pumheight = 5
o.helpheight = 10
o.showtabline = 0
o.guifont = "ComicCode Nerd Font:h13"
o.swapfile = false
o.statusline = " "
o.laststatus = 3
o.guicursor = "i:ver20,n-v-sm:block,c-ci-ve:ver20,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
o.cmdheight = 1
o.wrap = true
o.linebreak = true
o.shiftwidth = 2
o.tabstop = 2
o.cursorlineopt = "both" -- to enable cursorline!
o.mouse = "in"
o.swapfile = false
o.sessionoptions = "curdir,winsize,blank,terminal"
o.pumheight = 5
o.number = true
o.helpheight = 10
o.viewdir = os.getenv("HOME") .. "/.vim_view/"
o.wrap = true
vim.opt.breakat:append({ "，", "、", "。", "？" })
o.showtabline = 0
vim.opt.clipboard = ""
vim.opt.clipboard:prepend("unnamed")

require("utils.filetype").setup({
	vs = "glsl",
	fs = "glsl",
	qrc = "qrc",
})

require("utils.tabwidth").setup({
	python = 4,
	glsl = 4,
	rust = 4,
})

vim.bo.syntax = "on"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.diagnostic.config({

	underline = false,
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	virtual_text = false,
	float = {
		border = "single",
		format = function(diagnostic)
			return string.format(
				"%s (%s) [%s]",
				diagnostic.message,
				diagnostic.source,
				diagnostic.code or diagnostic.user_data.lsp.code
			)
		end,
	},
})
