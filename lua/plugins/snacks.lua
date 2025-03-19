return {
	"folke/snacks.nvim",
	lazy = false, -- Ensure it loads immediately
	config = function()
		local Snacks = require("snacks")

		-- Setup Snacks
		Snacks.setup({
			terminal = {
				win = { style = "terminal" },
			},
		})

		-- Keymap for buffer deletion
		vim.keymap.set("n", "<leader>bd", function()
			Snacks.bufdelete()
		end, { desc = "Delete Buffer" })

		vim.keymap.set("n", "<leader>bo", function()
			Snacks.bufdelete.other()
		end, { desc = "Delete Other Buffers" })

		vim.keymap.set("n", "<leader>bD", function()
			Snacks.bufdelete({ force = true })
		end, { desc = "Force Delete Buffer" })

		-- Keymap for terminal integration (non-floating)
		vim.keymap.set("n", "<leader>t", function()
			Snacks.terminal(nil, { win = { position = "bottom", style = "vertical", size = { height = 10 } } })
		end, { desc = "Open Terminal Bottom" })
		vim.keymap.set("t", "<leader>t", "<C-\\><C-n><cmd>q<CR>")
	end,
}
