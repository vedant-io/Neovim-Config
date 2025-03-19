return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local themes = require("telescope.themes")

			-- Telescope setup
			telescope.setup({
				defaults = {
					-- Default Telescope behavior (customize as needed)
					mappings = {
						i = {
							["<C-j>"] = "move_selection_next", -- Scroll down in results
							["<C-k>"] = "move_selection_previous", -- Scroll up in results
						},
					},
				},

				extensions = {
					buffers = {
						sort_lastused = true, -- Sort buffers by last used
						ignore_current_buffer = true,
					},
				},
			})

			-- Keymaps for Telescope
			vim.keymap.set("n", "<leader><leader>", function()
				builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
			end, { desc = "Find files in current file's directory" })

			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })

			vim.keymap.set("n", "<leader>fc", function()
				builtin.find_files({ cwd = "~/.config/nvim" })
			end, { desc = "Find files in Neovim config directory" })

			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search with live grep" })
		end,
	},
}
