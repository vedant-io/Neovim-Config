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

		-- Configure diagnostic signs
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

		-- Define a default on_attach function
		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, silent = true }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		end

		-- Optional autocmd for extra per-buffer setup
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(ev)
				-- You can add per-buffer config here
			end,
		})

		-- Setup Mason
		mason_lspconfig.setup()

		-- Setup all installed servers manually (since setup_handlers isn't available)
		local servers = mason_lspconfig.get_installed_servers()
		for _, server in ipairs(servers) do
			local opts = {
				on_attach = on_attach,
				capabilities = capabilities,
			}

			if server == "svelte" then
				opts.on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						buffer = bufnr,
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end
			elseif server == "graphql" then
				opts.filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" }
			elseif server == "emmet_ls" then
				opts.filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				}
			elseif server == "lua_ls" then
				opts.settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				}
			end

			lspconfig[server].setup(opts)
		end
	end,
}
