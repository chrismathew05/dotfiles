return {
	"ziontee113/color-picker.nvim",
	config = function()
		require("color-picker").setup({
			["icons"] = { "󰇝", "" },
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>hc", "<cmd>PickColor<cr>", { desc = "Hex Change Color" })
	end,
}
