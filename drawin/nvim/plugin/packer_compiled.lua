-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/champly/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/champly/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/champly/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/champly/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/champly/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    after = { "cmp_luasnip" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n5\0\1\5\0\4\0\0056\1\0\0009\1\1\1'\3\2\0009\4\3\0D\1\3\0\fordinal\b%s.\vformat\vstring—\2\1\0\f\0\15\0\0306\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\t\0005\3\a\0003\4\6\0=\4\b\3=\3\n\2B\0\2\1'\0\v\0)\1\1\0)\2\t\0)\3\1\0M\1\nÄ6\5\0\0009\5\f\0056\a\r\0009\a\14\a\18\t\0\0\18\n\4\0\18\v\4\0B\a\4\0A\5\0\1O\1ˆK\0\1\0\vformat\vstring\bcmdAnnoremap <silent><leader>%d <Cmd>BufferLineGoToBuffer %d<CR>\foptions\1\0\0\fnumbers\1\0\3\27always_show_bufferline\1\18modified_icon\b‚ú•\22buffer_close_icon\5\0\nsetup\15bufferline\frequire\18termguicolors\bopt\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    after = { "cmp-path" },
    after_files = { "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["cmp-nvim-lsp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after = { "cmp-buffer" },
    after_files = { "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["cmp-nvim-lua"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after = { "cmp-nvim-lsp" },
    after_files = { "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      cmp_luasnip = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["cmp-buffer"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after = { "cmp-nvim-lua" },
    after_files = { "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      LuaSnip = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["dashboard-nvim"] = {
    config = { "\27LJ\2\n„\19\0\0\a\0000\0Y6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\f\0005\2\n\0005\3\t\0=\3\v\2=\2\r\0015\2\15\0005\3\14\0=\3\v\2=\2\16\0015\2\18\0005\3\17\0=\3\v\2=\2\19\0015\2\21\0005\3\20\0=\3\v\2=\2\22\0015\2\24\0005\3\23\0=\3\v\2=\2\25\0015\2\27\0005\3\26\0=\3\v\2=\2\28\0015\2\30\0005\3\29\0=\3\v\2=\2\31\1=\1\b\0006\0\0\0009\0 \0'\2!\0B\0\2\0016\0\0\0009\0 \0'\2\"\0B\0\2\0016\0#\0'\2$\0B\0\2\0029\1%\0005\3*\0009\4&\0'\6'\0B\4\2\2\18\6\4\0009\4(\4B\4\2\2\18\6\4\0009\4)\4B\4\2\2=\4+\0039\4&\0'\6,\0B\4\2\2\18\6\4\0009\4(\4B\4\2\2\18\6\4\0009\4)\4B\4\2\2=\4-\0039\4&\0'\6.\0B\4\2\2\18\6\4\0009\4(\4B\4\2\2\18\6\4\0009\4)\4B\4\2\2=\4/\3B\1\2\1K\0\1\0\17n|<leader>ff\22DashboardFindFile\17n|<leader>fw\22DashboardFindWord\17n|<leader>fh\1\0\0\16with_silent\17with_noremap\25DashboardFindHistory\vmap_cr\22nvim_load_mapping\15utils.bind\frequire$ hi DashboardFooter guifg=gray ) hi DashboardShortcut guifg=#1E90FF \bcmd\14go_source\1\0\1\fcommand\23Telescope gosource\1\2\0\0;Óòß  Find Go Source Code                     leader fs\18find_dotfiles\1\0\1\fcommand\23Telescope dotfiles\1\2\0\0;Ôê•  Open Personal dotfiles                  leader fd\15new_buffer\1\0\1\fcommand\n=enew\1\2\0\0;ÔÖõ  Create new buffer                       leader n \14find_word\1\0\1\fcommand\22DashboardFindWord\1\2\0\0;ÔÜö  Find  word                              leader fw\14find_file\1\0\1\fcommand\22DashboardFindFile\1\2\0\0;ÔÖú  Find  File                              leader ff\17find_history\1\0\1\fcommand\25DashboardFindHistory\1\2\0\0;Ôú°  Recently opened files                   leader fh\17last_session\1\0\0\16description\1\0\1\fcommand\16SessionLoad\1\2\0\0;Ôë§  Recently laset session                  leader sl\29dashboard_custom_section\1\5\0\0RIf you think penguins are fat and waddle, you have never been attacked by one4running at you in excess of 100 miles per hour.\5R                                                            -- Linus Torvalds\28dashboard_custom_footer\1\v\0\0\5\5\5ò\1  ______         __                                      __     __           __            _                        __                             ò\1 /_  __/___     / /_  ___     ____  _____   ____  ____  / /_   / /_____     / /_  ___     (_)____   __  ______     / /_____     __  ______  __  __ ò\1  / / / __ \\   / __ \\/ _ \\   / __ \\/ ___/  / __ \\/ __ \\/ __/  / __/ __ \\   / __ \\/ _ \\   / / ___/  / / / / __ \\   / __/ __ \\   / / / / __ \\/ / / / ò\1 / / / /_/ /  / /_/ /  __/  / /_/ / /     / / / / /_/ / /_   / /_/ /_/ /  / /_/ /  __/  / (__  )  / /_/ / /_/ /  / /_/ /_/ /  / /_/ / /_/ / /_/ /  ò\1/_/  \\____/  /_.___/\\___/   \\____/_/     /_/ /_/\\____/\\__/   \\__/\\____/  /_.___/\\___/  /_/____/   \\__,_/ .___/   \\__/\\____/   \\__, /\\____/\\__,_/   ò\1                                                                                                      /_/                    /____/                \5\28dashboard_custom_header\14telescope dashboard_default_executive\6g\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/dashboard-nvim",
    url = "https://github.com/glepnir/dashboard-nvim"
  },
  ["far.vim"] = {
    config = { "\27LJ\2\n¢\3\0\0\6\0\17\0-6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0005\5\n\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\v\0'\3\b\0'\4\t\0005\5\f\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\a\0'\3\r\0'\4\14\0005\5\15\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\v\0'\3\r\0'\4\14\0005\5\16\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\1\0\2\fnoremap\2\vsilent\2\14:Farr<cr>\22<Replace-Shortcut\1\0\2\fnoremap\2\vsilent\2\6v\1\0\2\fnoremap\2\vsilent\2\14:Farf<cr>\20<Find-Shortcut>\6n\20nvim_set_keymap\bapi\31 set ignorecase smartcase \25 set regexpengine=1 \21 set lazyredraw \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/far.vim",
    url = "https://github.com/brooth/far.vim"
  },
  ["feline.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!modules.ui.statusline.layout\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/feline.nvim",
    url = "https://github.com/feline-nvim/feline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n¿\5\0\0\5\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0&current_line_blame_formatter_opts\1\0\1\18relative_time\2\28current_line_blame_opts\1\0\4\14virt_text\2\22ignore_whitespace\2\18virt_text_pos\beol\ndelay\3\0\nsigns\1\0\1\23current_line_blame\2\17changedelete\1\0\4\vlinehl\21GitSignsChangeLn\ttext\b‚ñë\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\14topdelete\1\0\4\vlinehl\21GitSignsDeleteLn\ttext\b‚Äæ\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vdelete\1\0\4\vlinehl\21GitSignsDeleteLn\ttext\6_\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vchange\1\0\4\vlinehl\21GitSignsChangeLn\ttext\b‚ñí\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\badd\1\0\0\1\0\4\vlinehl\18GitSignsAddLn\ttext\b‚îÇ\ahl\16GitSignsAdd\nnumhl\18GitSignsAddNr\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  gruvbox = {
    config = { "\27LJ\2\n|\0\0\3\0\6\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\0016\0\0\0009\0\3\0'\2\5\0B\0\2\1K\0\1\0\24colorscheme gruvbox\24set background=dark\bcmd\19gruvbox_italic\6g\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  ["lsp_signature.nvim"] = {
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { "\27LJ\2\nÎ\1\0\0\6\0\f\0\0216\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\a\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\n\0'\4\v\0004\5\0\0B\0\5\1K\0\1\0\25:TableModeToggle<cr>\15<leader>tm\vk<Bar>&table_mode_cell_text_object_i_map\6g\1\0\1\fnoremap\2\24:MarkdownPrevie<CR>\15<leader>kv\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  nerdcommenter = {
    config = { "\27LJ\2\n1\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\20NERDSpaceDelims\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/nerdcommenter",
    url = "https://github.com/preservim/nerdcommenter"
  },
  ["nui.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n¡\2\0\0\v\0\15\0\"6\0\0\0006\2\1\0'\3\2\0B\0\3\0036\2\0\0006\4\1\0'\5\3\0B\2\3\3\15\0\0\0X\4\18Ä\15\0\2\0X\4\16Ä9\4\4\0015\6\6\0005\a\5\0=\a\a\6B\4\2\0016\4\1\0'\6\b\0B\4\2\0029\5\t\4\18\a\5\0009\5\n\5'\b\v\0009\t\f\3B\t\1\0A\5\2\1X\4\5Ä9\4\4\0015\6\14\0005\a\r\0=\a\a\6B\4\2\1K\0\1\0\1\0\0\1\3\0\0\20TelescopePrompt\bvim\20on_confirm_done\17confirm_done\aon\nevent\bcmp\21disable_filetype\1\0\0\1\3\0\0\20TelescopePrompt\bvim\nsetup\"nvim-autopairs.completion.cmp\19nvim-autopairs\frequire\npcall\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "LuaSnip" },
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireÕ\1\0\2\b\0\n\0\0176\2\0\0'\4\1\0B\2\2\0026\3\3\0009\3\4\3'\5\5\0009\6\2\0018\6\6\0029\a\2\1B\3\4\2=\3\2\0015\3\a\0009\4\b\0009\4\t\0048\3\4\3=\3\6\1L\1\2\0\tname\vsource\1\0\3\rnvim_lua\n[Lua]\rnvim_lsp\n[LSP]\vbuffer\n[BUF]\tmenu\n%s %s\vformat\vstring\tkind&modules.completion.lspconfig_icon\frequireí\2\0\1\t\1\f\0!-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\23Ä6\1\2\0'\3\3\0B\1\2\0029\1\4\1B\1\1\2\15\0\1\0X\2\14Ä6\1\5\0009\1\6\0019\1\a\0016\3\5\0009\3\b\0039\3\t\3'\5\n\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\v\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\5!<Plug>luasnip-expand-or-jump\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\23expand_or_jumpable\fluasnip\frequire\21select_next_item\fvisibleá\2\0\1\t\1\f\0\"-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\24Ä6\1\2\0'\3\3\0B\1\2\0029\1\4\1)\3ˇˇB\1\2\2\15\0\1\0X\2\14Ä6\1\5\0009\1\6\0019\1\a\0016\3\5\0009\3\b\0039\3\t\3'\5\n\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\v\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\5\28<Plug>luasnip-jump-prev\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\rjumpable\fluasnip\frequire\21select_prev_item\fvisibleô\5\1\0\t\0-\0H6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\1\6\0005\3\n\0005\4\b\0003\5\a\0=\5\t\4=\4\v\0035\4\r\0003\5\f\0=\5\14\4=\4\15\0035\4\18\0009\5\16\0009\5\17\5B\5\1\2=\5\19\0049\5\16\0009\5\20\5B\5\1\2=\5\21\0049\5\16\0009\5\22\5)\a¸ˇB\5\2\2=\5\23\0049\5\16\0009\5\22\5)\a\4\0B\5\2\2=\5\24\0049\5\16\0009\5\25\5B\5\1\2=\5\26\0049\5\16\0009\5\27\5B\5\1\2=\5\28\0049\5\16\0009\5\29\0055\a \0009\b\30\0009\b\31\b=\b!\aB\5\2\2=\5\"\0043\5#\0=\5$\0043\5%\0=\5&\4=\4\16\0034\4\6\0005\5'\0>\5\1\0045\5(\0>\5\2\0045\5)\0>\5\3\0045\5*\0>\5\4\0045\5+\0>\5\5\4=\4,\3B\1\2\0012\0\0ÄK\0\1\0\fsources\1\0\1\tname\tpath\1\0\1\tname\rnvim_lua\1\0\1\tname\vbuffer\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\f<S-Tab>\0\n<Tab>\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\15formatting\vformat\1\0\0\0\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\21menuone,noselect\16completeopt\bopt\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    after = { "lsp_signature.nvim" },
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!modules.completion.lspconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\nÁ\1\0\0\b\0\f\0\0276\0\0\0006\2\1\0009\2\2\2'\3\3\0B\0\3\3\15\0\0\0X\2\rÄ6\2\1\0009\2\4\2'\4\5\0006\5\1\0009\5\6\0059\5\a\5'\a\b\0B\5\2\2&\4\5\4+\5\0\0005\6\t\0B\2\4\1X\2\6Ä6\2\1\0009\2\4\2\18\4\1\0'\5\n\0005\6\v\0B\2\4\1K\0\1\0\1\0\2\ftimeout\3Ë\a\ntitle\nError\nerror\1\0\2\ftimeout\3Ë\a\ntitle\fSuccess\b%:t\vexpand\afn\vSaved \vnotify\18silent write!\bcmd\bvim\npcallÙ\1\1\0\a\0\14\0\0256\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0006\0\3\0003\1\5\0=\1\4\0006\0\2\0'\2\6\0B\0\2\0029\1\a\0005\3\f\0009\4\b\0'\6\t\0B\4\2\2\18\6\4\0009\4\n\4B\4\2\2\18\6\4\0009\4\v\4B\4\2\2=\4\r\3B\1\2\1K\0\1\0\16n|<leader>s\1\0\0\16with_silent\17with_noremap\30<cmd>lua _save_file()<cr>\fmap_cmd\22nvim_load_mapping\15utils.bind\0\15_save_file\a_G\frequire\vnotify\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nã\a\0\0\t\0,\0N6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0004\1\0\0=\1\4\0006\0\5\0'\2\6\0B\0\2\0029\0\a\0004\1\4\0005\2\t\0005\3\b\0=\3\n\2\18\3\0\0'\5\v\0B\3\2\2=\3\f\2>\2\1\0015\2\14\0005\3\r\0=\3\n\2\18\3\0\0'\5\15\0B\3\2\2=\3\f\2>\2\2\0015\2\17\0005\3\16\0=\3\n\2\18\3\0\0'\5\18\0B\3\2\2=\3\f\2>\2\3\0016\2\0\0009\2\1\0025\3\20\0005\4\21\0=\4\22\0035\4\23\0=\4\24\3=\3\19\0026\2\5\0'\4\25\0B\2\2\0029\2\26\0025\4\27\0005\5\28\0=\5\29\0045\5\30\0=\5\31\0045\5 \0005\6!\0=\1\"\6=\6#\5=\5$\4B\2\2\0016\2\5\0'\4%\0B\2\2\0029\3&\0025\5*\0009\6'\2'\b(\0B\6\2\2\18\b\6\0009\6)\6B\6\2\2=\6+\5B\3\2\1K\0\1\0\tn|ff\1\0\0\17with_noremap\19NvimTreeToggle\vmap_cr\22nvim_load_mapping\15utils.bind\tview\rmappings\tlist\1\0\0\1\0\3\16auto_resize\2\nwidth\b19%\tside\tleft\ffilters\1\0\1\rdotfiles\2\24update_focused_file\1\0\1\venable\2\1\0\2\15update_cwd\2\15auto_close\2\nsetup\14nvim-tree\blsp\1\0\4\nerror\bÔÅó\thint\bÔÅ™\fwarning\bÔÅ±\tinfo\bÔÅö\bgit\1\0\a\runmerged\bÓúß\fdeleted\bÔëò\vstaged\b‚úì\frenamed\b‚ûú\fignored\b‚óå\14untracked\b‚òÖ\runstaged\b‚â†\1\0\2\fdefault\bÔÖú\fsymlink\bÔíÅ\20nvim_tree_icons\nsplit\1\0\0\1\2\0\0\6s\vvsplit\1\0\0\1\2\0\0\6v\acb\tedit\bkey\1\0\0\1\3\0\0\t<CR>\6o\23nvim_tree_callback\21nvim-tree.config\frequire\28nvim_tree_special_files\29nvim_tree_indent_markers\27nvim_tree_quit_on_open\6g\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-textobjects" },
    config = { "\27LJ\2\n˛\1\0\0\4\0\v\0\0196\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\4\0B\0\2\0016\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\b\0005\3\t\0=\3\n\2B\0\2\1K\0\1\0\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire,set foldexpr=nvim_treesitter#foldexpr()\24set foldmethod=expr\17nvim_command\bapi\bvim\0" },
    load_after = {},
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  rainbow = {
    config = { "\27LJ\2\nq\0\0\3\0\a\0\v6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0005\2\4\0=\2\6\1=\1\3\0K\0\1\0\15separately\1\0\0\1\0\1\rnerdtree\3\0\17rainbow_conf\19rainbow_active\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/rainbow",
    url = "https://github.com/luochen1990/rainbow"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/startuptime.vim",
    url = "https://github.com/tweekmonster/startuptime.vim"
  },
  ["symbols-outline.nvim"] = {
    config = { "\27LJ\2\nŸ\2\0\0\6\0\14\0\0176\0\0\0009\0\1\0005\1\3\0005\2\5\0005\3\4\0=\3\6\2=\2\a\1=\1\2\0006\0\0\0009\0\b\0009\0\t\0'\2\n\0'\3\v\0'\4\f\0005\5\r\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\24:SymbolsOutline<CR>\r<Space>o\6n\20nvim_set_keymap\bapi\fkeymaps\nclose\1\0\6\18goto_location\t<Cr>\18rename_symbol\6r\19focus_location\6o\19toggle_preview\6K\17hover_symbol\14<C-space>\17code_actions\6a\1\3\0\0\n<Esc>\6q\1\0\3\19relative_width\2\nwidth\0032\17auto_preview\1\20symbols_outline\6g\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    after = { "nvim-treesitter" },
    loaded = true,
    only_config = true
  },
  undotree = {
    config = { "\27LJ\2\nù\1\0\0\6\0\t\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\a\0)\1\1\0=\1\b\0K\0\1\0 undotree_SetFocusWhenToggle\6g\1\0\1\fnoremap\2\24:UndotreeToggle<cr>\14<leader>u\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-floaterm"] = {
    config = { "\27LJ\2\nı\2\0\0\a\0\18\1%6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0*\1\0\0=\1\5\0006\0\0\0009\0\1\0*\1\0\0=\1\6\0006\0\a\0'\2\b\0B\0\2\0029\1\t\0005\3\r\0009\4\n\0'\6\v\0B\4\2\2\18\6\4\0009\4\f\4B\4\2\2=\4\14\0039\4\15\0'\6\16\0B\4\2\2\18\6\4\0009\4\f\4B\4\2\2=\4\17\3B\1\2\1K\0\1\0\vt|<F3>\"<C-\\><C-n>:FloatermToggle<CR>\fmap_cmd\vn|<F3>\1\0\0\17with_noremap\19FloatermToggle\vmap_cr\22nvim_load_mapping\15utils.bind\frequire\20floaterm_height\19floaterm_width\23floaterm_autoclose\14zsh $1/$2\19floaterm_title\6g\bvimµÊÃô\19ô≥¶ˇ\3\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors",
    url = "https://github.com/terryma/vim-multiple-cursors"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vim-smoothie",
    url = "https://github.com/psliwka/vim-smoothie"
  },
  ["vim-sneak"] = {
    config = { "\27LJ\2\n„\4\0\0\6\0\21\00096\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0005\5\n\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\a\0'\3\v\0'\4\t\0005\5\f\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\r\0'\3\b\0'\4\14\0005\5\15\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\r\0'\3\v\0'\4\14\0005\5\16\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\17\0'\3\b\0'\4\18\0005\5\19\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\17\0'\3\v\0'\4\18\0005\5\20\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\1\0\2\fnoremap\2\vsilent\0028:<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>\6o\1\0\2\fnoremap\2\vsilent\2\1\0\2\fnoremap\2\vsilent\0028:<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>\6x\1\0\2\fnoremap\2\vsilent\2\6F\1\0\2\fnoremap\2\vsilent\0028:<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>\6f\6n\20nvim_set_keymap\bapi$;sftunq/SFGHLTUNRMQZ?0123456789\24sneak#target_labels\16sneak#label\6g\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vim-sneak",
    url = "https://github.com/justinmk/vim-sneak"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-table-mode"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/opt/vim-table-mode",
    url = "https://github.com/dhruvasagar/vim-table-mode"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\nñ\2\0\0\6\0\14\0\0296\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0004\5\0\0B\0\5\0016\0\0\0009\0\a\0009\0\b\0'\2\t\0'\3\f\0'\4\r\0004\5\0\0B\0\5\1K\0\1\0\f<Right>\n<M-l>\v<Left>\n<M-h>\6n\20nvim_set_keymap\bapi\1\0\4\18Add Cursor Up\n<M-k>\tUndo\6u\20Add Cursor Down\n<M-j>\tRedo\n<C-r>\fVM_maps\6\\\14VM_leader\21VM_show_warnings\6g\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  vimspector = {
    config = { "\27LJ\2\n‰\4\0\0\6\0\23\0-6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\6\0'\2\a\0B\0\2\0016\0\3\0009\0\b\0'\1\n\0=\1\t\0006\0\3\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\3\0009\0\v\0009\0\f\0'\2\r\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\3\0009\0\4\0'\2\20\0B\0\2\0016\0\3\0009\0\4\0'\2\21\0B\0\2\0016\0\3\0009\0\4\0'\2\22\0B\0\2\1K\0\1\0009 sign define vimspectorPC text=üëâ texthl=SpellBad ? sign define vimspectorBPDisabled text=üö´ texthl=Normal 7 sign define vimspectorBP text=üõë texthl=Normal \1\0\1\fnoremap\2\25:VimspectorReset<CR>\n<S-s>\1\0\2\vsilent\2\fnoremap\2(<CR>:lua show_vimspector_list()<CR>\15<leader>dt\6n\20nvim_set_keymap\bapi\18VISUAL_STUDIO\31vimspector_enable_mappings\6g\29modules/tools/vimspector\frequire\23 packadd nui.nvim \bcmd\bvim\vloaded\rnui.nvim\19packer_plugins\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vimspector",
    url = "https://github.com/puremourning/vimspector"
  },
  vimwiki = {
    config = { "\27LJ\2\nr\0\0\3\0\4\0\a6\0\0\0009\0\1\0004\1\3\0005\2\3\0>\2\1\1=\1\2\0K\0\1\0\1\0\3\bext\b.md\tpath ~/Dropbox/notebook/vimwiki/\vsyntax\rmarkdown\17vimwiki_list\6g\bvim\0" },
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/vimwiki",
    url = "https://github.com/vimwiki/vimwiki"
  },
  ["wildfire.vim"] = {
    loaded = true,
    path = "/Users/champly/.local/share/nvim/site/pack/packer/start/wildfire.vim",
    url = "https://github.com/gcmt/wildfire.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: symbols-outline.nvim
time([[Config for symbols-outline.nvim]], true)
try_loadstring("\27LJ\2\nŸ\2\0\0\6\0\14\0\0176\0\0\0009\0\1\0005\1\3\0005\2\5\0005\3\4\0=\3\6\2=\2\a\1=\1\2\0006\0\0\0009\0\b\0009\0\t\0'\2\n\0'\3\v\0'\4\f\0005\5\r\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\24:SymbolsOutline<CR>\r<Space>o\6n\20nvim_set_keymap\bapi\fkeymaps\nclose\1\0\6\18goto_location\t<Cr>\18rename_symbol\6r\19focus_location\6o\19toggle_preview\6K\17hover_symbol\14<C-space>\17code_actions\6a\1\3\0\0\n<Esc>\6q\1\0\3\19relative_width\2\nwidth\0032\17auto_preview\1\20symbols_outline\6g\bvim\0", "config", "symbols-outline.nvim")
time([[Config for symbols-outline.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nã\a\0\0\t\0,\0N6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0004\1\0\0=\1\4\0006\0\5\0'\2\6\0B\0\2\0029\0\a\0004\1\4\0005\2\t\0005\3\b\0=\3\n\2\18\3\0\0'\5\v\0B\3\2\2=\3\f\2>\2\1\0015\2\14\0005\3\r\0=\3\n\2\18\3\0\0'\5\15\0B\3\2\2=\3\f\2>\2\2\0015\2\17\0005\3\16\0=\3\n\2\18\3\0\0'\5\18\0B\3\2\2=\3\f\2>\2\3\0016\2\0\0009\2\1\0025\3\20\0005\4\21\0=\4\22\0035\4\23\0=\4\24\3=\3\19\0026\2\5\0'\4\25\0B\2\2\0029\2\26\0025\4\27\0005\5\28\0=\5\29\0045\5\30\0=\5\31\0045\5 \0005\6!\0=\1\"\6=\6#\5=\5$\4B\2\2\0016\2\5\0'\4%\0B\2\2\0029\3&\0025\5*\0009\6'\2'\b(\0B\6\2\2\18\b\6\0009\6)\6B\6\2\2=\6+\5B\3\2\1K\0\1\0\tn|ff\1\0\0\17with_noremap\19NvimTreeToggle\vmap_cr\22nvim_load_mapping\15utils.bind\tview\rmappings\tlist\1\0\0\1\0\3\16auto_resize\2\nwidth\b19%\tside\tleft\ffilters\1\0\1\rdotfiles\2\24update_focused_file\1\0\1\venable\2\1\0\2\15update_cwd\2\15auto_close\2\nsetup\14nvim-tree\blsp\1\0\4\nerror\bÔÅó\thint\bÔÅ™\fwarning\bÔÅ±\tinfo\bÔÅö\bgit\1\0\a\runmerged\bÓúß\fdeleted\bÔëò\vstaged\b‚úì\frenamed\b‚ûú\fignored\b‚óå\14untracked\b‚òÖ\runstaged\b‚â†\1\0\2\fdefault\bÔÖú\fsymlink\bÔíÅ\20nvim_tree_icons\nsplit\1\0\0\1\2\0\0\6s\vvsplit\1\0\0\1\2\0\0\6v\acb\tedit\bkey\1\0\0\1\3\0\0\t<CR>\6o\23nvim_tree_callback\21nvim-tree.config\frequire\28nvim_tree_special_files\29nvim_tree_indent_markers\27nvim_tree_quit_on_open\6g\bvim\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: gruvbox
time([[Config for gruvbox]], true)
try_loadstring("\27LJ\2\n|\0\0\3\0\6\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\0016\0\0\0009\0\3\0'\2\5\0B\0\2\1K\0\1\0\24colorscheme gruvbox\24set background=dark\bcmd\19gruvbox_italic\6g\bvim\0", "config", "gruvbox")
time([[Config for gruvbox]], false)
-- Config for: far.vim
time([[Config for far.vim]], true)
try_loadstring("\27LJ\2\n¢\3\0\0\6\0\17\0-6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0005\5\n\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\v\0'\3\b\0'\4\t\0005\5\f\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\a\0'\3\r\0'\4\14\0005\5\15\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\v\0'\3\r\0'\4\14\0005\5\16\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\1\0\2\fnoremap\2\vsilent\2\14:Farr<cr>\22<Replace-Shortcut\1\0\2\fnoremap\2\vsilent\2\6v\1\0\2\fnoremap\2\vsilent\2\14:Farf<cr>\20<Find-Shortcut>\6n\20nvim_set_keymap\bapi\31 set ignorecase smartcase \25 set regexpengine=1 \21 set lazyredraw \bcmd\bvim\0", "config", "far.vim")
time([[Config for far.vim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n‹\6\0\0\6\0 \0J6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\fÄ6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\3\0009\0\4\0'\2\6\0B\0\2\0016\0\3\0009\0\4\0'\2\a\0B\0\2\0016\0\b\0'\2\t\0B\0\2\0029\0\n\0005\2\14\0005\3\v\0005\4\f\0=\4\r\3=\3\15\0025\3\17\0005\4\16\0=\4\18\3=\3\19\2B\0\2\0016\0\b\0'\2\t\0B\0\2\0029\0\20\0'\2\18\0B\0\2\0016\0\b\0'\2\t\0B\0\2\0029\0\20\0'\2\21\0B\0\2\0016\0\b\0'\2\t\0B\0\2\0029\0\20\0'\2\22\0B\0\2\0016\0\3\0009\0\23\0009\0\24\0'\2\25\0'\3\26\0'\4\27\0004\5\0\0B\0\5\0016\0\3\0009\0\23\0009\0\24\0'\2\25\0'\3\28\0'\4\29\0004\5\0\0B\0\5\0016\0\3\0009\0\23\0009\0\24\0'\2\25\0'\3\30\0'\4\31\0004\5\0\0B\0\5\1K\0\1\0\28:Telescope dotfiles<cr>\15<leader>fd\28:Telescope gosource<cr>\15<leader>fs\27:Telescope buffers<cr>\15<leader>fb\6n\20nvim_set_keymap\bapi\rdotfiles\rgosource\19load_extension\15extensions\15fzy_native\1\0\0\1\0\2\25override_file_sorter\2\28override_generic_sorter\1\rdefaults\1\0\0\18layout_config\1\0\3\vheight\4ö≥ÊÃ\tô≥¶ˇ\3\nwidth\4ö≥ÊÃ\tô≥¶ˇ\3\20prompt_position\btop\1\0\4\20layout_strategy\15horizontal\21sorting_strategy\14ascending\18prompt_prefix\nüî≠ \20selection_caret\tÔÅ° \nsetup\14telescope\frequire&packadd telescope-fzy-native.nvim\23packadd popup.nvim\25packadd plenary.nvim\bcmd\bvim\vloaded\17plenary.nvim\19packer_plugins\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: vimwiki
time([[Config for vimwiki]], true)
try_loadstring("\27LJ\2\nr\0\0\3\0\4\0\a6\0\0\0009\0\1\0004\1\3\0005\2\3\0>\2\1\1=\1\2\0K\0\1\0\1\0\3\bext\b.md\tpath ~/Dropbox/notebook/vimwiki/\vsyntax\rmarkdown\17vimwiki_list\6g\bvim\0", "config", "vimwiki")
time([[Config for vimwiki]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
try_loadstring("\27LJ\2\n„\19\0\0\a\0000\0Y6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\f\0005\2\n\0005\3\t\0=\3\v\2=\2\r\0015\2\15\0005\3\14\0=\3\v\2=\2\16\0015\2\18\0005\3\17\0=\3\v\2=\2\19\0015\2\21\0005\3\20\0=\3\v\2=\2\22\0015\2\24\0005\3\23\0=\3\v\2=\2\25\0015\2\27\0005\3\26\0=\3\v\2=\2\28\0015\2\30\0005\3\29\0=\3\v\2=\2\31\1=\1\b\0006\0\0\0009\0 \0'\2!\0B\0\2\0016\0\0\0009\0 \0'\2\"\0B\0\2\0016\0#\0'\2$\0B\0\2\0029\1%\0005\3*\0009\4&\0'\6'\0B\4\2\2\18\6\4\0009\4(\4B\4\2\2\18\6\4\0009\4)\4B\4\2\2=\4+\0039\4&\0'\6,\0B\4\2\2\18\6\4\0009\4(\4B\4\2\2\18\6\4\0009\4)\4B\4\2\2=\4-\0039\4&\0'\6.\0B\4\2\2\18\6\4\0009\4(\4B\4\2\2\18\6\4\0009\4)\4B\4\2\2=\4/\3B\1\2\1K\0\1\0\17n|<leader>ff\22DashboardFindFile\17n|<leader>fw\22DashboardFindWord\17n|<leader>fh\1\0\0\16with_silent\17with_noremap\25DashboardFindHistory\vmap_cr\22nvim_load_mapping\15utils.bind\frequire$ hi DashboardFooter guifg=gray ) hi DashboardShortcut guifg=#1E90FF \bcmd\14go_source\1\0\1\fcommand\23Telescope gosource\1\2\0\0;Óòß  Find Go Source Code                     leader fs\18find_dotfiles\1\0\1\fcommand\23Telescope dotfiles\1\2\0\0;Ôê•  Open Personal dotfiles                  leader fd\15new_buffer\1\0\1\fcommand\n=enew\1\2\0\0;ÔÖõ  Create new buffer                       leader n \14find_word\1\0\1\fcommand\22DashboardFindWord\1\2\0\0;ÔÜö  Find  word                              leader fw\14find_file\1\0\1\fcommand\22DashboardFindFile\1\2\0\0;ÔÖú  Find  File                              leader ff\17find_history\1\0\1\fcommand\25DashboardFindHistory\1\2\0\0;Ôú°  Recently opened files                   leader fh\17last_session\1\0\0\16description\1\0\1\fcommand\16SessionLoad\1\2\0\0;Ôë§  Recently laset session                  leader sl\29dashboard_custom_section\1\5\0\0RIf you think penguins are fat and waddle, you have never been attacked by one4running at you in excess of 100 miles per hour.\5R                                                            -- Linus Torvalds\28dashboard_custom_footer\1\v\0\0\5\5\5ò\1  ______         __                                      __     __           __            _                        __                             ò\1 /_  __/___     / /_  ___     ____  _____   ____  ____  / /_   / /_____     / /_  ___     (_)____   __  ______     / /_____     __  ______  __  __ ò\1  / / / __ \\   / __ \\/ _ \\   / __ \\/ ___/  / __ \\/ __ \\/ __/  / __/ __ \\   / __ \\/ _ \\   / / ___/  / / / / __ \\   / __/ __ \\   / / / / __ \\/ / / / ò\1 / / / /_/ /  / /_/ /  __/  / /_/ / /     / / / / /_/ / /_   / /_/ /_/ /  / /_/ /  __/  / (__  )  / /_/ / /_/ /  / /_/ /_/ /  / /_/ / /_/ / /_/ /  ò\1/_/  \\____/  /_.___/\\___/   \\____/_/     /_/ /_/\\____/\\__/   \\__/\\____/  /_.___/\\___/  /_/____/   \\__,_/ .___/   \\__/\\____/   \\__, /\\____/\\__,_/   ò\1                                                                                                      /_/                    /____/                \5\28dashboard_custom_header\14telescope dashboard_default_executive\6g\bvim\0", "config", "dashboard-nvim")
time([[Config for dashboard-nvim]], false)
-- Config for: vim-visual-multi
time([[Config for vim-visual-multi]], true)
try_loadstring("\27LJ\2\nñ\2\0\0\6\0\14\0\0296\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0004\5\0\0B\0\5\0016\0\0\0009\0\a\0009\0\b\0'\2\t\0'\3\f\0'\4\r\0004\5\0\0B\0\5\1K\0\1\0\f<Right>\n<M-l>\v<Left>\n<M-h>\6n\20nvim_set_keymap\bapi\1\0\4\18Add Cursor Up\n<M-k>\tUndo\6u\20Add Cursor Down\n<M-j>\tRedo\n<C-r>\fVM_maps\6\\\14VM_leader\21VM_show_warnings\6g\bvim\0", "config", "vim-visual-multi")
time([[Config for vim-visual-multi]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\n5\0\1\5\0\4\0\0056\1\0\0009\1\1\1'\3\2\0009\4\3\0D\1\3\0\fordinal\b%s.\vformat\vstring—\2\1\0\f\0\15\0\0306\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\t\0005\3\a\0003\4\6\0=\4\b\3=\3\n\2B\0\2\1'\0\v\0)\1\1\0)\2\t\0)\3\1\0M\1\nÄ6\5\0\0009\5\f\0056\a\r\0009\a\14\a\18\t\0\0\18\n\4\0\18\v\4\0B\a\4\0A\5\0\1O\1ˆK\0\1\0\vformat\vstring\bcmdAnnoremap <silent><leader>%d <Cmd>BufferLineGoToBuffer %d<CR>\foptions\1\0\0\fnumbers\1\0\3\27always_show_bufferline\1\18modified_icon\b‚ú•\22buffer_close_icon\5\0\nsetup\15bufferline\frequire\18termguicolors\bopt\bvim\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: vimspector
time([[Config for vimspector]], true)
try_loadstring("\27LJ\2\n‰\4\0\0\6\0\23\0-6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\6\0'\2\a\0B\0\2\0016\0\3\0009\0\b\0'\1\n\0=\1\t\0006\0\3\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\3\0009\0\v\0009\0\f\0'\2\r\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\3\0009\0\4\0'\2\20\0B\0\2\0016\0\3\0009\0\4\0'\2\21\0B\0\2\0016\0\3\0009\0\4\0'\2\22\0B\0\2\1K\0\1\0009 sign define vimspectorPC text=üëâ texthl=SpellBad ? sign define vimspectorBPDisabled text=üö´ texthl=Normal 7 sign define vimspectorBP text=üõë texthl=Normal \1\0\1\fnoremap\2\25:VimspectorReset<CR>\n<S-s>\1\0\2\vsilent\2\fnoremap\2(<CR>:lua show_vimspector_list()<CR>\15<leader>dt\6n\20nvim_set_keymap\bapi\18VISUAL_STUDIO\31vimspector_enable_mappings\6g\29modules/tools/vimspector\frequire\23 packadd nui.nvim \bcmd\bvim\vloaded\rnui.nvim\19packer_plugins\0", "config", "vimspector")
time([[Config for vimspector]], false)
-- Config for: vim-floaterm
time([[Config for vim-floaterm]], true)
try_loadstring("\27LJ\2\nı\2\0\0\a\0\18\1%6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0*\1\0\0=\1\5\0006\0\0\0009\0\1\0*\1\0\0=\1\6\0006\0\a\0'\2\b\0B\0\2\0029\1\t\0005\3\r\0009\4\n\0'\6\v\0B\4\2\2\18\6\4\0009\4\f\4B\4\2\2=\4\14\0039\4\15\0'\6\16\0B\4\2\2\18\6\4\0009\4\f\4B\4\2\2=\4\17\3B\1\2\1K\0\1\0\vt|<F3>\"<C-\\><C-n>:FloatermToggle<CR>\fmap_cmd\vn|<F3>\1\0\0\17with_noremap\19FloatermToggle\vmap_cr\22nvim_load_mapping\15utils.bind\frequire\20floaterm_height\19floaterm_width\23floaterm_autoclose\14zsh $1/$2\19floaterm_title\6g\bvimµÊÃô\19ô≥¶ˇ\3\0", "config", "vim-floaterm")
time([[Config for vim-floaterm]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\nÁ\1\0\0\b\0\f\0\0276\0\0\0006\2\1\0009\2\2\2'\3\3\0B\0\3\3\15\0\0\0X\2\rÄ6\2\1\0009\2\4\2'\4\5\0006\5\1\0009\5\6\0059\5\a\5'\a\b\0B\5\2\2&\4\5\4+\5\0\0005\6\t\0B\2\4\1X\2\6Ä6\2\1\0009\2\4\2\18\4\1\0'\5\n\0005\6\v\0B\2\4\1K\0\1\0\1\0\2\ftimeout\3Ë\a\ntitle\nError\nerror\1\0\2\ftimeout\3Ë\a\ntitle\fSuccess\b%:t\vexpand\afn\vSaved \vnotify\18silent write!\bcmd\bvim\npcallÙ\1\1\0\a\0\14\0\0256\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0006\0\3\0003\1\5\0=\1\4\0006\0\2\0'\2\6\0B\0\2\0029\1\a\0005\3\f\0009\4\b\0'\6\t\0B\4\2\2\18\6\4\0009\4\n\4B\4\2\2\18\6\4\0009\4\v\4B\4\2\2=\4\r\3B\1\2\1K\0\1\0\16n|<leader>s\1\0\0\16with_silent\17with_noremap\30<cmd>lua _save_file()<cr>\fmap_cmd\22nvim_load_mapping\15utils.bind\0\15_save_file\a_G\frequire\vnotify\bvim\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: vim-sneak
time([[Config for vim-sneak]], true)
try_loadstring("\27LJ\2\n„\4\0\0\6\0\21\00096\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0005\5\n\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\a\0'\3\v\0'\4\t\0005\5\f\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\r\0'\3\b\0'\4\14\0005\5\15\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\r\0'\3\v\0'\4\14\0005\5\16\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\17\0'\3\b\0'\4\18\0005\5\19\0B\0\5\0016\0\0\0009\0\5\0009\0\6\0'\2\17\0'\3\v\0'\4\18\0005\5\20\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\1\0\2\fnoremap\2\vsilent\0028:<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>\6o\1\0\2\fnoremap\2\vsilent\2\1\0\2\fnoremap\2\vsilent\0028:<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>\6x\1\0\2\fnoremap\2\vsilent\2\6F\1\0\2\fnoremap\2\vsilent\0028:<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>\6f\6n\20nvim_set_keymap\bapi$;sftunq/SFGHLTUNRMQZ?0123456789\24sneak#target_labels\16sneak#label\6g\bvim\0", "config", "vim-sneak")
time([[Config for vim-sneak]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-web-devicons ]]
vim.cmd [[ packadd feline.nvim ]]

-- Config for: feline.nvim
try_loadstring("\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!modules.ui.statusline.layout\frequire\0", "config", "feline.nvim")

time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'undotree', 'nerdcommenter', 'nvim-treesitter', 'rainbow'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-lspconfig', 'nvim-autopairs', 'gitsigns.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
