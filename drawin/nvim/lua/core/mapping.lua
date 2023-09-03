-- vim map
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>n", ":enew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>bd", ":bd!<CR>", { noremap = true })

-- -- https://www.reddit.com/r/neovim/comments/ro6oye/open_link_from_neovim/
vim.api.nvim_set_keymap("n", "gx", ":silent execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>", { noremap = true })

-- session
vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load()<cr>]], {})

-- loop set mouse mode
vim.api.nvim_set_keymap("n", "<leader>sm", ":lua vim.opt.mouse = vim.opt.mouse._value == 'v' and 'a' or 'v'<CR>",
	{ noremap = true })

-- Call figlet
-- brew install figlet
vim.api.nvim_set_keymap("n", "fl", ":r !figlet ", { noremap = true })

-- Finial
-- command line mode
vim.api.nvim_set_keymap("c", "<C-a>", "<Home>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-e>", "<End>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-b>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-f>", "<Right>", { noremap = true })
-- insert mode
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<C-o>gj", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<C-o>gk", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-a>", "<Home>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-e>", "<End>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-b>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-f>", "<Right>", { noremap = true })

-- force write
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee % >/dev/null", { noremap = true })

-- split
vim.api.nvim_set_keymap("n", "sh", ":set splitright<CR>:vs<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "sl", ":set nosplitright<CR>:vs<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "sk", ":set splitbelow<CR>:sp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "sj", ":set nosplitbelow<CR>:sp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "ss", "<C-w>t<C-w>H", { noremap = true })
vim.api.nvim_set_keymap("n", "sp", "<C-w>t<c-w>K", { noremap = true })

-- Tab
vim.api.nvim_set_keymap("n", "<leader>tu", ":tabe<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tn", ":-tabnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tp", ":+tabnext<CR>", { noremap = true })

-- move window with cursor
vim.api.nvim_set_keymap("n", "<C-j>", "<C-W>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-W>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-W>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-W>l", { noremap = true })

-- hightline
vim.api.nvim_set_keymap("n", "<F2>", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<F2>", "<C-O>:nohlsearch<CR>", { noremap = true, silent = true })

-- cheat-sheet
-- https://www.nerdfonts.com/cheat-sheet
