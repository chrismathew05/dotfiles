ALL_LANG_SETTINGS = {
	python = { lsp = { "pyright" }, fmt = { "isort", "black", "ruff" }, lint = { "ruff" }, dap = { "debugpy" } },
	javascript = { lsp = { "typescript-language-server" }, fmt = { "prettier" }, lint = { "eslint_d" } },
	typescript = { lsp = { "typescript-language-server" }, fmt = { "prettier" }, lint = { "eslint_d" } },
	css = { lsp = { "tailwindcss-language-server" }, fmt = { "prettier" }, lint = { "stylelint" } },
	typescriptreact = {
		lsp = { "typescript-language-server", "tailwindcss-language-server" },
		fmt = { "prettier" },
		lint = { "eslint_d" },
	},
	html = { lsp = { "html-lsp" }, fmt = { "prettier" }, lint = { "htmlhint" } },
	lua = { lsp = { "lua-language-server" }, fmt = { "stylua" }, lint = { "selene" } },
	json = { lsp = { "json-lsp" }, fmt = { "fixjson" }, lint = { "jsonlint" } },
	dockerfile = { lsp = { "dockerfile-language-server" }, fmt = { "prettier" }, lint = { "hadolint" } },
	yaml = { lsp = { "docker-compose-language-service" }, fmt = { "prettier" } },
	sh = { lsp = { "bash-language-server" }, fmt = { "shfmt" }, lint = { "shellcheck" } },
	zsh = { lsp = { "bash-language-server" }, fmt = { "shfmt" }, lint = { "shellcheck" } },
}

-- get list of all tools outlined in lang settings above
local function get_all_tools()
	local ensure_installed = {}
	for _, lang_settings in pairs(ALL_LANG_SETTINGS) do
		for k, tools in pairs(lang_settings) do
			if k ~= "lsp_settings" then
				for _, t in pairs(tools) do
					if not ensure_installed[t] then
						table.insert(ensure_installed, t)
					end
				end
			end
		end
	end

	return ensure_installed
end

-- Function to format files based on filetype
local function format_file()
	local filetype = vim.bo.filetype
	local filename = vim.fn.expand("%:p")
	local lang_settings = ALL_LANG_SETTINGS[filetype]

	if lang_settings then
		local formatters = lang_settings["fmt"]
		for _, formatter in pairs(formatters) do
			local cmd = "silent !" .. formatter .. " " .. filename

			if formatter == "fixjson" or formatter == "prettier" then
				cmd = cmd .. " --write"
			end

			vim.cmd(cmd)
		end
	else
		vim.lsp.buf.format()
		print("No formatter configured for filetype: ", filetype)
	end
end

-- Function to lint file with linter specified above
local function lint_file()
	local filetype = vim.bo.filetype
	local lang_settings = ALL_LANG_SETTINGS[filetype]

	if lang_settings then
		local linter = lang_settings["lint"]
		if linter then
			require("lint").try_lint(linter)
		end
	end
end

return {
	{ "williamboman/mason.nvim" },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = get_all_tools(),
			})

			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },

		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- custom keymaps
			local keymap = vim.keymap

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf, silent = true }

					-- set keybinds
					opts.desc = "Show LSP references"
					keymap.set("n", "<leader>lR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

					opts.desc = "Go to declaration"
					keymap.set("n", "<leader>lg", vim.lsp.buf.declaration, opts) -- go to declaration

					opts.desc = "Show LSP definitions"
					keymap.set("n", "<leader>lf", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

					opts.desc = "Show LSP implementations"
					keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

					opts.desc = "Show LSP type definitions"
					keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

					opts.desc = "See available code actions"
					keymap.set({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = "Smart rename"
					keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts) -- smart rename

					opts.desc = "Show buffer diagnostics"
					keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

					opts.desc = "Show line diagnostics"
					keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- show diagnostics for line

					opts.desc = "Go to previous diagnostic"
					keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

					opts.desc = "Go to next diagnostic"
					keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

					opts.desc = "Show documentation for what is under cursor"
					keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

					opts.desc = "Restart LSP"
					keymap.set("n", "<leader>lx", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
				end,
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Autocommand to format on file save
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*",
				callback = format_file,
			})

			-- Autocommand to lint on file save
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = lint_file,
			})
		end,
	},
	{ "mfussenegger/nvim-dap" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{
		"laytan/tailwind-sorter.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm ci && npm run build",
		config = function()
			require("tailwind-sorter").setup({
				on_save_enabled = true,
				on_save_pattern = {
					"*.html",
					"*.js",
					"*.jsx",
					"*.tsx",
					"*.twig",
					"*.hbs",
					"*.php",
					"*.heex",
					"*.astro",
				},
			})
		end,
	},
}
