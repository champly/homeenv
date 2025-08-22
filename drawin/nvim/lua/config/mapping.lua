-- Basic editing
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
vim.keymap.set("n", "<leader>n", ":enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bd", ":bd!<CR>", { desc = "Force close buffer" })

-- https://www.reddit.com/r/neovim/comments/ro6oye/open_link_from_neovim/
-- Open URL or file under cursor (macOS: open)
vim.keymap.set("n", "gx", ":silent execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>", { silent = true })

-- Session
vim.keymap.set("n", "<leader>sl", function() require("persistence").load() end,
	{ desc = "Load last session", silent = true })

-- Obsidian
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian today<cr>", { desc = "Obsidian Today", silent = true })

-- loop set mouse mode
vim.keymap.set("n", "<leader>sm", ":lua vim.opt.mouse = vim.opt.mouse._value == 'v' and 'a' or 'v'<CR>",
	{ desc = "Toggle mouse mode", silent = true })

-- Call figlet
-- brew install figlet
-- vim.api.nvim_set_keymap("n", "fl", ":r !figlet ", { noremap = true })

-- Finial
-- command line mode
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
-- insert mode
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<C-o>gj")
vim.keymap.set("i", "<C-k>", "<C-o>gk")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-a>", "<Home>")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-f>", "<Right>")

-- force write
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null", { desc = "Sudo write" })

-- split
vim.keymap.set("n", "sh", ":set splitright<CR>:vs<CR>", { desc = "Vertical split right" })
vim.keymap.set("n", "sl", ":set nosplitright<CR>:vs<CR>", { desc = "Vertical split left" })
vim.keymap.set("n", "sk", ":set splitbelow<CR>:sp<CR>", { desc = "Horizontal split below" })
vim.keymap.set("n", "sj", ":set nosplitbelow<CR>:sp<CR>", { desc = "Horizontal split above" })
vim.keymap.set("n", "ss", "<C-w>t<C-w>H", { desc = "Rotate to vertical" })
vim.keymap.set("n", "sp", "<C-w>t<c-w>K", { desc = "Rotate to horizontal" })

-- Tab
vim.keymap.set("n", "<leader>tu", ":tabe<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tn", ":tabprevious<CR>", { desc = "Prev tab" })
vim.keymap.set("n", "<leader>tp", ":tabnext<CR>", { desc = "Next tab" })

-- move window with cursor
vim.keymap.set("n", "<C-j>", "<C-W>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-W>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-h>", "<C-W>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-W>l", { desc = "Move to right window" })

-- hightline
vim.keymap.set("n", "<F2>", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })
vim.keymap.set("i", "<F2>", "<C-O>:nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

-- cheat-sheet
-- https://www.nerdfonts.com/cheat-sheet
