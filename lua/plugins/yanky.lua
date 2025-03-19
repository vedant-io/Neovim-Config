return {
	{
		"gbprod/yanky.nvim",
		dependencies = { "kkharji/sqlite.lua" }, -- Adding sqlite for better persistence
		opts = {
			ring = {
				history_length = 200, -- Increased for more extensive history
				storage = "sqlite", -- More reliable than shada
				storage_path = vim.fn.stdpath("data") .. "/yanky_history.sqlite", -- Custom path for sqlite storage
				sync_with_numbered_registers = true, -- Sync with numbered registers
				ignore_registers = { "_" }, -- Ignore black hole register
				update_register_on_cycle = true, -- Automatically update registers when cycling
			},
			system_clipboard = {
				sync_with_ring = true, -- Sync with system clipboard
				clipboard_register = "+", -- Use system clipboard explicitly
			},
			highlight = {
				on_put = true, -- Highlight text when pasted
				on_yank = true, -- Highlight text when yanked
				timer = 700, -- Longer highlight duration
			},
			preserve_cursor_position = {
				enabled = true, -- Keep cursor position intact after paste
			},
			textobj = {
				enabled = true, -- Enable text objects for yank
			},
		},
		config = function(_, opts)
			-- Load Yanky and apply options
			require("yanky").setup(opts)

			-- Yanky keymaps
			local keymap = vim.keymap.set
			local yanky = require("yanky")

			-- Basic mappings for yank ring
			keymap({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
			keymap({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			keymap({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
			keymap({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

			-- Yank-ring navigation
			keymap("n", "<C-p>", "<Plug>(YankyPreviousEntry)", { desc = "Cycle backward in yank ring" })
			keymap("n", "<C-n>", "<Plug>(YankyNextEntry)", { desc = "Cycle forward in yank ring" })

			-- Advanced mappings for linewise/indent-aware puts
			keymap("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
			keymap("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
			keymap("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
			keymap("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
			keymap("n", "=p", "<Plug>(YankyPutAfterFilter)")

			-- Clear yank history
			vim.api.nvim_create_user_command("ClearYankHistory", yanky.clear_history, { desc = "Clear Yanky history" })
		end,
	},
}
