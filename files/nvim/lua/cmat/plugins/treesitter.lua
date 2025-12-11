return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({
			-- enable syntax highlighting
			highlight = {
				enable = true,
			},

			-- enable indentation
			indent = { enable = true },

			-- auto install syntax support for new file types
			auto_install = true,

			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = { enable = true },

			-- ensure these language parsers are installed
			ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"gitignore",
				"hcl",
				"html",
				"http",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"prisma",
				"python",
				"regex",
				"rst",
				"sql",
				"terraform",
				"typescript",
				"tsx",
				"vim",
				"xml",
				"yaml",
				"query",
				"vimdoc",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
