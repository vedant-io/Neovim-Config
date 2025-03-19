return {
	{
		"kelly-lin/ranger.nvim",
		config = function()
			-- Configure ranger.nvim
			require("ranger-nvim").setup({
				replace_netrw = true, -- Replace netrw with ranger.nvim
				keybinds = { -- Ranger-specific keybinds
					["<C-n>"] = "NvimTreeFindFile", -- Example keybind to find file (optional)
				},
			})

			-- Keymap to open Ranger in floating or full-screen mode
			vim.keymap.set("n", "<leader>ef", function()
				require("ranger-nvim").open(true) -- Open in floating mode
			end, {
				noremap = true,
				silent = true,
				desc = "Open Ranger File Manager (Floating)",
			})

			-- Optional: Keymap to open in full-screen mode
			vim.keymap.set("n", "<leader>eF", function()
				require("ranger-nvim").open(false) -- Open in full-screen mode
			end, {
				noremap = true,
				silent = true,
				desc = "Open Ranger File Manager (Full-Screen)",
			})

			-- Optional: Close Ranger using Esc (automatically in terminal mode)
			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "term://*ranger*",
				callback = function()
					vim.keymap.set("t", "<Esc>", [[<C-\><C-n>:bd!<CR>]], {
						buffer = 0,
						noremap = true,
						silent = true,
					})
				end,
			})
		end,
	},
}
