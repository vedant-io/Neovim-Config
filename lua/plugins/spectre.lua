return {
	-- Add Spectre plugin
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = { "SpectreOpen", "SpectreClose" },
		config = function()
			require("spectre").setup()

			-- Keybindings in normal mode
			vim.keymap.set("n", "<leader>S", function()
				require("spectre").toggle()
			end, { desc = "Toggle Spectre" })

			vim.keymap.set("n", "<leader>sw", function()
				require("spectre").open_visual({ select_word = true })
			end, { desc = "Search current word" })

			-- Visual mode keybinding
			vim.keymap.set("v", "<leader>sw", function()
				require("spectre").open_visual()
			end, { desc = "Search selected word" })

			-- Keybinding for searching in current file
			vim.keymap.set("n", "<leader>sp", function()
				require("spectre").open_file_search({ select_word = true })
			end, { desc = "Search in current file" })
		end,
	},
}
