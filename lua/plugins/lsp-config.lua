return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Import required plugins
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Configure diagnostic signs using the new API (preferred over vim.fn.sign_define)
		vim.diagnostic.config({
			signs = {
				active = {
					[vim.diagnostic.severity.ERROR] = { text = " " },
					[vim.diagnostic.severity.WARN] = { text = " " },
					[vim.diagnostic.severity.HINT] = { text = "󰠠 " },
					[vim.diagnostic.severity.INFO] = { text = " " },
				},
			},
		})

		-- Enable autocompletion for every LSP server
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Define a default on_attach function for keymaps and other settings.
		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, silent = true }
			-- Example LSP keymaps – adjust these as needed:
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			-- You can add more mappings here.
		end

		-- (Optional) Create an autocmd for LspAttach to do additional per-buffer setup.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(ev)
				-- Additional per-buffer configuration can be placed here.
			end,
		})

		-- Ensure Mason is set up before registering server handlers.
		mason_lspconfig.setup()

		mason_lspconfig.setup_handlers({
			-- Default handler for all installed LSP servers.
			function(server_name)
				lspconfig[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			-- Custom handler for the svelte server.
			["svelte"] = function()
				lspconfig.svelte.setup({
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							buffer = bufnr,
							callback = function(ctx)
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
					capabilities = capabilities,
				})
			end,
			-- Custom handler for the GraphQL server.
			["graphql"] = function()
				lspconfig.graphql.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			-- Custom handler for the emmet language server.
			["emmet_ls"] = function()
				lspconfig.emmet_ls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,
			-- Custom handler for the Lua language server.
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT)
								version = "LuaJIT",
							},
							diagnostics = {
								-- Recognize the `vim` global
								globals = { "vim" },
							},
							workspace = {
								-- Make the server aware of Neovim runtime files
								library = vim.api.nvim_get_runtime_file("", true),
							},
							telemetry = {
								enable = false,
							},
						},
					},
				})
			end,
		})
	end,
}
