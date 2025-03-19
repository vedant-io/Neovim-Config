-- This file is automatically loaded by init.lua

local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Auto reload file if changed externally
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("auto_reload"),
	callback = function()
		if vim.bo.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({ timeout = 250 })
	end,
})

-- Resize splits when the window resizes
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("restore_cursor"),
	callback = function(event)
		local buf = event.buf
		if vim.bo[buf].filetype ~= "gitcommit" and not vim.b[buf].restored_cursor then
			vim.b[buf].restored_cursor = true
			local mark = vim.api.nvim_buf_get_mark(buf, '"')
			local lcount = vim.api.nvim_buf_line_count(buf)
			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end
	end,
})

-- Close specific filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"help",
		"man",
		"lspinfo",
		"qf",
		"checkhealth",
		"startuptime",
		"tsplayground",
		"spectre_panel",
		"neotest-output",
		"neotest-summary",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})

-- Set wrap & spell check for text-based filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("text_wrap_spell"),
	pattern = { "markdown", "text", "plaintex", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fix conceal level for JSON-like filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Automatically create missing directories before saving
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(event)
		local file = vim.fn.fnamemodify(event.match, ":p")
		local dir = vim.fn.fnamemodify(file, ":h")
		if not vim.loop.fs_stat(dir) then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom_term_open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})
