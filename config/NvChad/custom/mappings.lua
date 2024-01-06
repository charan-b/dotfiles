---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		-- save
		["<leader>w"] = { "<cmd> w <CR>", "save file" },
		-- quit
		["<leader>q"] = { "<cmd> q <CR>", "quit file" },
		-- move current line/block up/down
		["<A-j>"] = { ":m .+1<CR>==", "move line down" },
		["<A-k>"] = { ":m .-2<CR>==", "move line up" },
		-- nvimtree toggle
		["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

		-- For a more complex keymap
		["<leader>lf"] = {
			function()
				vim.lsp.buf.format("shfmt")
			end,
			"shell format",
		},
	},
	i = {
		-- Move current line / block with Alt-j/k ala vscode.
		["<A-j>"] = { "<Esc>:m .+1<CR>==gi" },
		-- Move current line / block with Alt-j/k ala vscode.
		["<A-k>"] = { "<Esc>:m .-2<CR>==gi" },
	},
	v = {
		-- Better indenting
		["<"] = { "<gv", "Left Indenting" },
		[">"] = { ">gv", "Right Indenting" },
	},

	x = {
		-- Move current line / block with Alt-j/k ala vscode.
		["<A-j>"] = { ":m '>+1<CR>gv-gv" },
		["<A-k>"] = { ":m '<-2<CR>gv-gv" },
	},

	c = {
		-- navigate tab completion with <c-j> and <c-k>
		-- runs conditionally
		-- ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
		-- ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
	},
}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
	},
}

M.dap_python = {
	plugin = true,
	n = {
		["<leader>dpr"] = {
			function()
				require("dap-python").test_method()
			end,
		},
	},
}

-- more keybinds!
-- M.nvimtree = {
--   n = {
--     { key = "v", action = "edit" },
--   },
-- }

return M
