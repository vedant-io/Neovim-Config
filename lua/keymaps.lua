local keymap = vim.keymap.set

-- Keymaps
keymap("n", "<leader><leader>q", ":q<CR>")

--Basic Keymaps
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-j>", "<C-w>j")

vim.g.copilot_no_tab_map = true -- Disable default Tab mapping
vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Accept("<CR>")', { silent = true, expr = true }) -- Map <C-J> to accept Copilot suggestions

-- Select All
keymap("n", "<C-a>", "gg<S-v>G")

--Auto Session Keymaps
keymap("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
keymap("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })

--NvimTree Keymaps
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap("n", "<leader>ee", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

--LSP Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
		keymap("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
		keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
		keymap("n", "gi", "<cm>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
		keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
		-- Code actions
		keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions
		-- Rename and diagnostics
		keymap("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
		keymap("n", "<leader>M", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show diagnostics for file
		keymap("n", "<leader>m", vim.diagnostic.open_float, opts) -- show diagnostics for line
		-- Documentation and hover
		keymap("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
		-- Restart LSP
		keymap("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
	end,
})
