return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({})
	end,
}

-- 	"Exafunction/codeium.vim",
-- 	config = function()
-- 		vim.g.codeium_disable_bindings = 1
--
-- 		vim.keymap.set("i", "<Tab>", function()
-- 			return vim.fn["codeium#Accept"]()
-- 		end, { expr = true, silent = true })
--
-- 		vim.keymap.set("i", "<C-l>", function()
-- 			return vim.fn["codeium#CycleCompletions"](1)
-- 		end, { expr = true, silent = true })
--
-- 		vim.keymap.set("i", "<C-h>", function()
-- 			return vim.fn["codeium#Clear"]()
-- 		end, { expr = true, silent = true })
-- 	end,
