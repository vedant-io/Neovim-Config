return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				-- Web Development
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				mdx = { "prettier" },
				graphql = { "prettier" },
				astro = { "prettier" },
				liquid = { "prettier" },

				-- Backend & General Purpose
				python = { "isort", "black" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				go = { "gofmt", "golines" },
				java = { "google-java-format" },
				kotlin = { "ktlint" },
				dart = { "dart_format" },
				php = { "php_cs_fixer" },
				ruby = { "rubocop" },
				swift = { "swiftformat" },

				-- Shell & Configuration Files
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				dockerfile = { "dockfmt" },
				toml = { "taplo" },
				ini = { "prettier" },
				sql = { "sql-formatter" },

				-- C, C++, and Systems Languages
				c = { "clang-format" },
				cpp = { "clang-format" },
				cs = { "csharpier" },
				nim = { "nimpretty" },

				-- Haskell, Lisp, and Functional Languages
				haskell = { "fourmolu" },
				clojure = { "zprint" },
				fsharp = { "fantomas" },
				ocaml = { "ocamlformat" },
				elixir = { "mix" },

				-- Miscellaneous & Less Common
				ron = { "ronfmt" },
				terraform = { "terraform_fmt" },
				nix = { "alejandra" },
				r = { "styler" },
			},

			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000, -- Increased timeout to prevent failures on larger files
			},
		})

		-- Keybinding for manual formatting
		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
