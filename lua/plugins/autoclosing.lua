return {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter", -- Load only when entering insert mode for better performance
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename matching tags
				enable_close_on_slash = true, -- Auto close when typing </
			},
			ft = {
				-- Web development
				"html",
				"xml",
				"svg",
				"php",

				-- JavaScript & TypeScript
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"jsx",
				"tsx",

				-- Modern frontend frameworks
				"svelte",
				"vue",
				"astro",
				"marko",
				"liquid",

				-- Templating & UI-related formats
				"blade",
				"ejs",
				"hbs",
				"jinja",
				"twig",
				"pug",
				"slim",

				-- Miscellaneous
				"mdx",
				"rescript",
				"htmldjango",
			},
		})
	end,
}
