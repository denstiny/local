return {
	"nvim-tree/nvim-tree.lua",

	dependencies = {
		{ "nvim-tree/nvim-web-devicons", opts = {} },
	},
	config = function()
		require("nvim-tree").setup({
			root_dirs = { "build", ".git", ".tasks.ini" },
			prefer_startup_root = true,
			sync_root_with_cwd = true,
			reload_on_bufenter = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
				ignore_list = { "rust" },
			},
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
				side = "left",
			},
			renderer = {
				group_empty = true,
				indent_markers = {
					enable = true,
				},
			},
			filters = {
				dotfiles = false,
				git_ignored = true,
			},
			notify = {
				threshold = vim.log.levels.OFF,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end
				api.config.mappings.default_on_attach(bufnr)
				vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
				vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("new vertical split"))
				vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("new vertical split"))
				vim.keymap.set("n", "d", api.fs.trash, opts("trash"))
				vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
			end,
		})
		local Snacks = require("snacks")
		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = { "netrw" },
			group = vim.api.nvim_create_augroup("NetrwOnRename", { clear = true }),
			callback = function()
				vim.keymap.set("n", "R", function()
					local original_file_path = vim.b.netrw_curdir .. "/" .. vim.fn["netrw#Call"]("NetrwGetWord")

					vim.ui.input(
						{ prompt = "Move/rename to:", default = original_file_path },
						function(target_file_path)
							if target_file_path and target_file_path ~= "" then
								local file_exists = vim.uv.fs_access(target_file_path, "W")

								if not file_exists then
									vim.uv.fs_rename(original_file_path, target_file_path)

									Snacks.rename.on_rename_file(original_file_path, target_file_path)
								else
									vim.notify(
										"File '" .. target_file_path .. "' already exists! Skipping...",
										vim.log.levels.ERROR
									)
								end

								-- Refresh netrw
								vim.cmd(":Ex " .. vim.b.netrw_curdir)
							end
						end
					)
				end, { remap = true, buffer = true })
			end,
		})

		-- nvim-tree rename file
		local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
		vim.api.nvim_create_autocmd("User", {
			pattern = "NvimTreeSetup",
			callback = function()
				local events = require("nvim-tree.api").events
				events.subscribe(events.Event.NodeRenamed, function(data)
					if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
						data = data
						Snacks.rename.on_rename_file(data.old_name, data.new_name)
					end
				end)
			end,
		})
	end,
}
