local map = vim.keymap.set
local del = vim.keymap.del

map("n", "tr", "<cmd>NvimTreeToggle<cr>", { desc = "nvimtree toggle window" })
map("n", "U", "<cmd>UndotreeToggle<cr>", { desc = "undo tree" })
map("n", "L", "<cmd>Telescope oldfiles<cr>", { desc = "old files list" })
map("n", "B", "<cmd>Telescope buffers<cr>", { desc = "buffers" })
map("n", "<c-f>", "<cmd>Telescope fd<cr>", { desc = "file list" })
map("n", "fs", "<cmd>Telescope grep_string<cr>", { desc = "find string" })
map("n", "<leader>git", function()
	require("snacks").lazygit()
end)
