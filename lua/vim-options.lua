-- Set indentation to spaces with a width of 2
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2 -- Set tab width to 2 spaces
vim.opt.softtabstop = 2 -- Number of spaces per tab when editing
vim.opt.shiftwidth = 2 -- Indent/outdent by 2 spaces
vim.opt.smartindent = true -- Auto-indent new lines based on syntax

-- Display line numbers
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative numbers for better navigation

-- Clipboard settings
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for copy-paste

-- UI Enhancements
vim.opt.cursorline = true -- Highlight current line
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.signcolumn = "yes" -- Always show sign column to prevent shifting
vim.opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
vim.opt.wrap = false -- Disable line wrapping for better readability

-- Search improvements
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Case-sensitive search if query contains uppercase
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.incsearch = true -- Show matches while typing search query

-- Better split behavior
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt.splitright = true -- Open vertical splits to the right

-- Undo & Backup settings
vim.opt.undofile = true -- Enable persistent undo
vim.opt.backup = false -- Disable backup files
vim.opt.swapfile = false -- Disable swap files

-- Fast update time for responsiveness
vim.opt.updatetime = 250 -- Reduce update time for better UI performance
vim.opt.timeoutlen = 500 -- Faster key sequence timeout for mappings

-- Auto-read files changed outside Neovim
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	command = "checktime",
})

-- Automatically remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[silent! %s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})
