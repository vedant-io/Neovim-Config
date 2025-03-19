return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers", -- Show buffers (default)
			numbers = "ordinal", -- Show buffer numbers for quick navigation
			close_command = "bdelete! %d", -- Close buffers with `bdelete`
			right_mouse_command = "bdelete! %d", -- Allow closing with right-click
			diagnostics = "nvim_lsp", -- Show LSP diagnostics in bufferline
			separator_style = "slant", -- Add a visually appealing separator
			show_close_icon = false, -- Hide the close icon for a cleaner look
			show_buffer_close_icons = true, -- Show close icons on individual buffers
			always_show_bufferline = true, -- Keep the bufferline visible
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "center",
				},
			},
		},
	},
}
