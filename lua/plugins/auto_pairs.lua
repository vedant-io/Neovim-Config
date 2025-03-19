return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp", -- Ensure nvim-cmp is installed
	},
	config = function()
		-- Import nvim-autopairs
		local autopairs = require("nvim-autopairs")

		-- Configure autopairs
		autopairs.setup({
			check_ts = true, -- Enable treesitter integration
			ts_config = {
				lua = { "string" }, -- Don't add pairs in Lua string nodes
				javascript = { "template_string" }, -- Don't add pairs in JavaScript template strings
				java = false, -- Disable treesitter checks for Java
			},
			fast_wrap = {
				map = "<M-e>", -- Use Alt+e for wrapping with pairs
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				offset = 0, -- Offset from the pattern match
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})

		-- Import nvim-autopairs completion functionality
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		-- Import nvim-cmp plugin
		local cmp = require("cmp")

		-- Make autopairs and nvim-cmp completion work together
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
