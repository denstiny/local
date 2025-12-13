local get_default_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- required by nvim-ufo
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	return capabilities
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_buf_conf", { clear = true }),
	callback = function(event_context)
		local client = vim.lsp.get_client_by_id(event_context.data.client_id)
		-- vim.print(client.name, client.server_capabilities)

		if not client then
			return
		end

		local bufnr = event_context.buf

		-- Mappings.
		local map = function(mode, l, r, opts)
			opts = opts or {}
			opts.silent = true
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "gr", function()
			vim.cmd("Lspsaga finder def+tyd+ref+imp")
		end, { desc = "go to references" })
		map("n", "gd", function()
			require("snacks").picker.lsp_definitions()
		end, { desc = "go to definition" })
		map("n", "K", function()
			vim.cmd("Lspsaga hover_doc")
		end)
		map("n", "re", function()
			vim.cmd("Lspsaga rename")
		end, { desc = "varialbe rename" })
		map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "LSP code action" })
		map("n", "gn", function()
			vim.cmd("Lspsaga diagnostic_jump_next")
		end, { desc = "diagnostic_jump_next" })
		map("n", "gp", function()
			vim.cmd("Lspsaga diagnostic_jump_prev")
		end, { desc = "diagnostic_jump_prev" })
		map("n", "gl", function()
			vim.cmd("Lspsaga show_line_diagnostics")
		end, { desc = "diagnostic_jump_prev" })
		map("n", "mr", function()
			vim.cmd("Lspsaga rename")
		end, { desc = "rename" })
		-- Set some key bindings conditional on server capabilities
		-- Disable ruff hover feature in favor of Pyright
		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end

		-- Uncomment code below to enable inlay hint from language server, some LSP server supports inlay hint,
		-- but disable this feature by default, so you may need to enable inlay hint in the LSP server config.
		-- vim.lsp.inlay_hint.enable(true, {buffer=bufnr})

		-- The blow command will highlight the current variable and its usages in the buffer.
		if client.server_capabilities.documentHighlightProvider then
			local gid = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
			vim.api.nvim_create_autocmd("CursorHold", {
				group = gid,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.document_highlight()
				end,
			})

			vim.api.nvim_create_autocmd("CursorMoved", {
				group = gid,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			})
		end
	end,
	nested = true,
	desc = "Configure buffer keymap and behavior based on LSP",
})

-- Enable lsp servers when they are available

local capabilities = get_default_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 500,
	},
})

-- A mapping from lsp server name to the executable name
local enabled_lsp_servers = {
	pyright = "delance-langserver",
	ruff = "ruff",
	lua_ls = "lua-language-server",
	clangd = "clangd",
	vimls = "vim-language-server",
	bashls = "bash-language-server",
	yamlls = "yaml-language-server",
}

for server_name, lsp_executable in pairs(enabled_lsp_servers) do
	if vim.fn.executable(lsp_executable) then
		vim.lsp.enable(server_name)
	else
		local msg = string.format(
			"Executable '%s' for server '%s' not found! Server will not be enabled",
			lsp_executable,
			server_name
		)
		vim.notify(msg, vim.log.levels.WARN, { title = "Nvim-config" })
	end
end
