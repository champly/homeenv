-- vim-plug diff with packer.nvim
-- https://github.com/junegunn/vim-plug#plug-options
-- https://github.com/wbthomason/packer.nvim#specifying-plugins
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	-- download_result = fn.system({'ls', '-l', install_path})
	-- print("download_result: " .. download_result)

	-- Only required if you have packer configured as `opt`
	vim.cmd [[packadd! packer.nvim]]
end

vim.g.modules_path = "~/.local/share/nvim/site/pack/packer/start/"

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- file system explorer
	-- use 'preservim/nerdtree'
	-- use 'Xuyuanp/nerdtree-git-plugin'
	-- use 'ryanoasis/vim-devicons'
	-- We recommend updating the parsers on update
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'kyazdani42/nvim-tree.lua'
	use 'kyazdani42/nvim-web-devicons'

	-- go language support
	-- use 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

	-- neovim 0.5 > lsp
	-- use 'neovim/nvim-lspconfig'
	-- use 'nvim-lua/completion-nvim'

	-- Debugger
	-- https://github.com/puremourning/vimspector#supported-languages
	use {'puremourning/vimspector', run = './install_gadget.py --enable-go --enable-rust' }

	-- code-completion engine
	-- use 'Valloric/YouCompleteMe'
	use { 'neoclide/coc.nvim', branch = 'release' }

	-- annotate plugin: https://github.com/preservim/nerdcommenter#settings
	use 'preservim/nerdcommenter'
	-- use 'tomtom/tcomment_vim'

	-- class outline viewer
	-- use 'majutsushi/tagbar'
	-- use 'liuchengxu/vista.vim'

	-- parentheses improved
	use 'luochen1990/rainbow'

	-- fzf
	-- use { 'junegunn/fzf', run = { -> fzf#install() }
	-- use 'junegunn/fzf.vim'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-fzy-native.nvim'

	-- Insert or delete brackets, parens, quotes in pair
	use 'jiangmiao/auto-pairs'

	-- notify
	use 'rcarriga/nvim-notify'

	-- Lean & mean status/tabline for vim that's light as air.
	-- use 'vim-airline/vim-airline'
	-- use 'vim-airline/vim-airline-themes'
	use 'akinsho/bufferline.nvim'
	use { 'glepnir/galaxyline.nvim', branch = 'main'}

	-- theme
	-- use 'tomasiser/vim-code-dark'
	use 'morhetz/gruvbox'
	-- use 'rakr/vim-one'
	-- use 'rktjmp/lush.nvim'
	-- use 'npxbr/gruvbox.nvim'

	-- choice multi line
	use { 'mg979/vim-visual-multi', branch = 'master'}
	use 'terryma/vim-multiple-cursors'

	-- Git
	-- use 'tpope/vim-fugitive'
	use 'airblade/vim-gitgutter'

	-- tpope plug
	use 'tpope/vim-eunuch'
	use 'tpope/vim-repeat'
	-- https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94
	use 'tpope/vim-surround'
	use 'gcmt/wildfire.vim'

	-- The plug-in visualizes undo history and makes it easier to browse and switch between different undo branches
	use 'mbbill/undotree'

	-- Jump to any location specified by two characters.
	use 'justinmk/vim-sneak'

	-- snipets
	-- will modify tab map, so forbide
	-- use 'SirVer/ultisnips'

	-- VimWiki is a personal wiki for Vim
	use 'vimwiki/vimwiki'

	-- UI Component Library for Neovim.
	use 'MunifTanjim/nui.nvim'

	-- syntax highlighting, matching rules and mapping for the original Markdown and extensions
	use 'plasticboy/vim-markdown'
	-- use 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
	use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', ft = { 'markdown' }}
	-- use {
	--     'iamcco/markdown-preview.nvim',
	--     -- run = function() fn['mkdp#util#install()'](0) end,
	--     run = ':call mkdp#util#install()',
	--     ft = { 'markdown', 'packer.nvim' }
	-- }
	use 'dhruvasagar/vim-table-mode'

	-- quick find word
	use 'mhinz/vim-grepper'
	use 'brooth/far.vim'

	-- float terminal
	use 'voldikss/vim-floaterm'

	-- This plugin provides a start screen
	-- use 'mhinz/vim-startify'
	use 'glepnir/dashboard-nvim'

	-- debug
	use 'tweekmonster/startuptime.vim'

	use 'psliwka/vim-smoothie'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)