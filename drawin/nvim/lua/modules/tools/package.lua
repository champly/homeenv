local package = require("core.pack").package
local conf = require("modules.tools.config")

package({
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",
	dependencies = "telescope.nvim",
	build = ":TSUpdate",
	config = conf.nvim_treesitter,
})

package({
	"iamcco/markdown-preview.nvim",
	build = "cd app && yarn install",
	ft = { "markdown" },
	init = conf.markdown_preview_nvim_setup,
	dependencies = {
		{ "plasticboy/vim-markdown" },
		{ "dhruvasagar/vim-table-mode" },
	}
})

package({
	"OXY2DEV/markview.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons"
	},
	ft = { "markdown" },
})

-- annotate plugin: https://github.com/preservim/nerdcommenter#settings
package({
	"preservim/nerdcommenter",
	event = "BufRead",
	init = function()
		-- 注释的时候自动加个空格,强迫症必配
		vim.g.NERDSpaceDelims = 1
	end
})

-- The plug-in visualizes undo history and makes it easier to browse and switch between different undo branches
package({
	"mbbill/undotree",
	event = "BufRead",
	config = conf.undotree,
})

-- VimWiki is a personal wiki for Vim
package({
	"vimwiki/vimwiki",
	cmd = {
		"VimwikiMakeDiaryNote",
		"VimwikiIndex",
	},
	init = conf.vimwiki_setup,
})

-- choice multi line
package({
	"mg979/vim-visual-multi",
	event = "BufReadPre",
	branch = "master",
	config = conf.vim_visual_multi_setup,
})

-- -- Jump to any location specified by two characters.
-- package({
--     "phaazon/hop.nvim",
--     event = "BufReadPre",
--     config = conf.hop_nvim,
--     init = conf.hop_nvim_setup,
-- })
package({
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = {
				enable = false,
			},
			char = {
				jump_labels = true
			}
		},
	},
	-- stylua: ignore
	keys = {
		{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
		{ "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
		{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
		{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
	},
})

-- symbols outline
package({
	"hedyhli/outline.nvim",
	event = "BufRead",
	config = conf.outline_nvim,
})

-- tpope plug
package({
	"tpope/vim-eunuch",
	event = "BufReadPre",
})

package({
	"tpope/vim-repeat",
	event = "BufReadPre",
})

-- https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94
package({
	"tpope/vim-surround",
	event = "BufReadPre",
})

-- quick choice
package({
	"gcmt/wildfire.vim",
	event = "BufReadPre",
})

-- Debugger
package({
	"mfussenegger/nvim-dap",
	event = "BufReadPre",
	config = conf.nvim_dap,
})

package({
	"rcarriga/nvim-dap-ui",
	event = "BufReadPre",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio"
	},
	config = conf.nvim_dap_ui,
})

-- Insert or delete brackets, parens, quotes in pair
package({
	"windwp/nvim-autopairs",
	event = "BufReadPre",
	config = conf.autopairs,
})

-- class outline viewer
-- use 'majutsushi/tagbar'
-- use 'liuchengxu/vista.vim'

-- Smooth scrolling for Vim done right
package({
	"psliwka/vim-smoothie",
	event = "BufReadPre",
	init = conf.smoothie_setup,
})

package({
	"monkoose/matchparen.nvim",
	event = "BufReadPre",
	config = conf.matchparen,
})

package({
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
		options = { "buffers", "curdir", "tabpages", "winsize" },
		pre_save = nil,
	}
})

-- search and replace
package({
	"windwp/nvim-spectre",
	keys = {
		"<leader>S",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = conf.nvim_spectre
})

package({
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"codelldb",
			"biome",
			"prettier",
			"lua-language-server",
			"clangd",
			"yamlfmt",
			"goimports",
			"gofumpt",
			"taplo",
		},
	},
	config = function(_, opts)
		-- https://github.com/williamboman/mason.nvim/issues/1309#issuecomment-1555018732
		require("mason").setup(opts)
		local registry = require "mason-registry"
		registry.refresh(function()
			for _, pkg_name in ipairs(opts.ensure_installed) do
				local pkg = registry.get_package(pkg_name)
				if not pkg:is_installed() then
					pkg:install()
				end
			end
		end)
	end,
})

package({
	"stevearc/conform.nvim",
	config = function()
		local opts = {
			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true,
			},
			format_after_save = {
				lsp_format = "never",
			},
			formatters_by_ft = {
				["go"] = { "goimports", "gofumpt" },
				["json"] = { "biome" },
				["jsonc"] = { "biome" },
				["markdown"] = { "prettier" },
				["markdown.mdx"] = { "prettier" },
				["yaml"] = { "yamlfmt" },
				["toml"] = { "taplo" },
			},
			formatters = {
				biome = {
					args = {
						"format",
						"--stdin-file-path",
						"$FILENAME",
						"--config-path",
						vim.fn.stdpath("config") .. "/external/format",
					},
				}
			}
		}
		require("conform").setup(opts)
	end
})

package({
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	enabled = vim.uv.os_uname().sysname == "Darwin",
	opts = {
		workspaces = {
			{
				name = "icloud",
				path = "~/Library/Mobile Documents/com~apple~CloudDocs/notebook",
			},
		},
		daily_notes = {
			folder = "Daily/tx"
		}
	},
})

package({
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewFileHistory",
	},
	opts = {
		view = {
			merge_tool = {
				layout = "diff3_mixed",
			}
		}
	}
})

-- -- -- TODO: config this plugin with keymaps
-- package({
--     "folke/todo-comments.nvim",
--     dependencies = { "nvim-lua/plenary.nvim" },
--     opts = {}
-- })
