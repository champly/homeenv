-- vim map
vim.api.nvim_set_keymap("n", "Y", "y$", {})
vim.api.nvim_set_keymap("n", "<leader>n", ":enew<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>bd", ":bd!<CR>", {})

-- insert
vim.api.nvim_set_keymap("n", "<leader>ss", ":<C-u>SessionSave<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>sl", ":<C-u>SessionLoad<CR>", {})

-- Call figlet
-- brew install figlet
vim.api.nvim_set_keymap("n", "fl", ":r !figlet ", {})
