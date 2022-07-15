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
local package_path_str = "/home/ysavani/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/ysavani/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/ysavani/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/ysavani/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/ysavani/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-ultisnips"] = {
    after_files = { "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-nvim-ultisnips/after/plugin/cmp_nvim_ultisnips.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-pandoc-references"] = {
    after_files = { "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-pandoc-references/after/plugin/cmp-pandoc-references.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-pandoc-references",
    url = "https://github.com/jc-doyle/cmp-pandoc-references"
  },
  ["cmp-path"] = {
    after_files = { "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["dial.nvim"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/dial.nvim",
    url = "https://github.com/monaqa/dial.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\23current_line_blame\2\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/guihua.lua",
    url = "https://github.com/ray-x/guihua.lua"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n†\2\0\0\4\0\v\0\0256\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0009\0\3\0\18\2\0\0009\0\4\0'\3\5\0B\0\3\0016\0\0\0009\0\1\0009\0\3\0\18\2\0\0009\0\4\0'\3\6\0B\0\3\0016\0\a\0'\2\b\0B\0\2\0029\0\t\0005\2\n\0B\0\2\1K\0\1\0\1\0\3\31show_current_context_start\2\25show_current_context\2\25space_char_blankline\6 \nsetup\21indent_blankline\frequire\feol:â†´\14space:â‹…\vappend\14listchars\tlist\bopt\bvim\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  kommentary = {
    config = { "\27LJ\2\n¦\1\0\0\4\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\4\0005\3\5\0B\0\3\1K\0\1\0\1\0\1 prefer_single_line_comments\2\fdefault\23configure_language\26use_extended_mappings\22kommentary.config\frequire\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/kommentary",
    url = "https://github.com/b3nj5m1n/kommentary"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\fonedark\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/hoob3rt/lualine.nvim"
  },
  ["navigator.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14navigator\frequire\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/navigator.lua",
    url = "https://github.com/ray-x/navigator.lua"
  },
  ["numb.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\tnumb\frequire\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/numb.nvim",
    url = "https://github.com/nacro90/numb.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nc\0\1\6\0\6\1\f9\1\0\0\18\3\1\0009\1\1\0019\4\2\0\23\4\0\0049\5\2\0B\1\4\0026\2\3\0009\2\4\0025\4\5\0\18\5\1\0D\2\3\0\1\4\0\0\a()\a{}\a[]\17tbl_contains\bvim\bcol\bsub\tline\2’\1\0\1\a\0\a\2\0176\1\0\0009\1\1\0019\1\2\1)\3\0\0B\1\2\2:\1\2\0019\2\3\0\18\4\2\0009\2\4\2\23\5\0\1\22\6\1\1B\2\4\0026\3\0\0009\3\5\0035\5\6\0\18\6\2\0D\3\3\0\1\4\0\0\t(  )\t{  }\t[  ]\17tbl_contains\bsub\tline\24nvim_win_get_cursor\bapi\bvim\2\4*\0\1\2\0\2\0\a9\1\0\0\6\1\1\0X\1\2€+\1\1\0X\2\1€+\1\2\0L\1\2\0\6)\tchar*\0\1\2\0\2\0\a9\1\0\0\6\1\1\0X\1\2€+\1\1\0X\2\1€+\1\2\0L\1\2\0\6}\tchar*\0\1\2\0\2\0\a9\1\0\0\6\1\1\0X\1\2€+\1\1\0X\2\1€+\1\2\0L\1\2\0\6]\tcharé\b\1\0\r\0'\1Á\0016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0026\1\0\0'\3\1\0B\1\2\0026\2\0\0'\4\a\0B\2\2\0029\3\b\0014\5\t\0\18\6\0\0'\b\t\0'\t\t\0005\n\n\0B\6\4\2\18\b\6\0009\6\v\0069\t\f\2'\v\r\0B\t\2\0A\6\1\2\18\b\6\0009\6\v\0069\t\14\2'\v\15\0B\t\2\0A\6\1\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2>\6\1\5\18\6\0\0'\b\18\0'\t\18\0B\6\3\2\18\b\6\0009\6\v\0063\t\19\0B\6\3\2\18\b\6\0009\6\20\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\21\0063\t\22\0B\6\3\2>\6\2\5\18\6\0\0'\b\23\0'\t\24\0B\6\3\2\18\b\6\0009\6\v\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\20\0063\t\25\0B\6\3\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\21\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\26\6'\t\27\0B\6\3\2>\6\3\5\18\6\0\0'\b\23\0'\t\28\0B\6\3\2\18\b\6\0009\6\v\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\20\0063\t\29\0B\6\3\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\21\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\26\6'\t\30\0B\6\3\2>\6\4\5\18\6\0\0'\b\23\0'\t\31\0B\6\3\2\18\b\6\0009\6\v\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\20\0063\t \0B\6\3\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\21\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\26\6'\t!\0B\6\3\2>\6\5\0056\6\0\0'\b\1\0B\6\2\0029\6\"\6'\b#\0B\6\2\2\18\b\6\0009\6\v\0069\t\14\2'\v$\0)\f\2\0B\t\3\0A\6\1\2>\6\6\0056\6\0\0'\b\1\0B\6\2\0029\6\"\6'\b%\0B\6\2\2\18\b\6\0009\6\v\0069\t\14\2'\v$\0)\f\2\0B\t\3\0A\6\1\2>\6\a\0056\6\0\0'\b\1\0B\6\2\0029\6\"\6'\b&\0B\6\2\2\18\b\6\0009\6\v\0069\t\14\2'\v$\0)\f\2\0B\t\3\0A\6\1\0?\6\0\0B\3\2\1K\0\1\0\6{\6[\alr\6(\rget_rule\6]\0\a ]\6}\0\a }\6)\fuse_key\0\a )\5\0\rwith_del\14with_move\0\6 \tnone\fwith_cr\a%$\27not_before_regex_check\a%%\26not_after_regex_check\14with_pair\1\3\0\0\btex\nlatex\6$\14add_rules\25nvim-autopairs.conds\24nvim-autopairs.rule\21disable_filetype\1\5\0\0\20TelescopePrompt\vguihua\16guihua_rust\15clap_input\1\0\2\rcheck_ts\2\22ignored_next_char\v[%w%.]\nsetup\19nvim-autopairs\frequire\17€€À™\4\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-path", "cmp-buffer", "cmp-pandoc-references", "ultisnips", "cmp-nvim-lsp" },
    loaded = true,
    only_config = true
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-startup.lua"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17nvim-startup\frequire\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/nvim-startup.lua",
    url = "https://github.com/henriquehbr/nvim-startup.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-textobjects", "nvim-treesitter-refactor" },
    loaded = true,
    only_config = true
  },
  ["nvim-treesitter-refactor"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/onedark.vim",
    url = "https://github.com/joshdick/onedark.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ultisnips = {
    after = { "cmp-nvim-ultisnips", "vim-snippets" },
    after_files = { "/home/ysavani/.local/share/nvim/site/pack/packer/opt/ultisnips/after/plugin/UltiSnips_after.vim" },
    load_after = {},
    loaded = true,
    needs_bufread = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/opt/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  ["vim-python-pep8-indent"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/vim-python-pep8-indent",
    url = "https://github.com/Vimjas/vim-python-pep8-indent"
  },
  ["vim-sandwich"] = {
    config = { "\27LJ\2\nO\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0000runtime macros/sandwich/keymap/surround.vim\bcmd\bvim\0" },
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/vim-sandwich",
    url = "https://github.com/machakann/vim-sandwich"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/start/vim-sneak",
    url = "https://github.com/justinmk/vim-sneak"
  },
  ["vim-snippets"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/ysavani/.local/share/nvim/site/pack/packer/opt/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: vim-sandwich
time([[Config for vim-sandwich]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0000runtime macros/sandwich/keymap/surround.vim\bcmd\bvim\0", "config", "vim-sandwich")
time([[Config for vim-sandwich]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n:\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19UltiSnips#Anon\afn\bvimž\5\1\0\a\0%\0B6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0035\4\b\0=\4\t\0035\4\f\0009\5\n\0009\5\v\5B\5\1\2=\5\r\0049\5\n\0009\5\14\5B\5\1\2=\5\15\0049\5\n\0009\5\16\5B\5\1\2=\5\17\0049\5\n\0009\5\18\5B\5\1\2=\5\19\4=\4\n\0035\4\20\0=\4\21\0034\4\6\0005\5\22\0>\5\1\0045\5\23\0>\5\2\0045\5\24\0>\5\3\0045\5\25\0>\5\4\0045\5\26\0>\5\5\4=\4\27\3B\1\2\0016\1\28\0009\1\29\0019\1\30\1\a\1\31\0X\1\16€6\1\28\0009\1\29\0019\1\30\1\a\1 \0X\1\v€6\1\28\0009\1\29\0019\1\30\1\a\1!\0X\1\6€9\1\2\0009\1\"\0015\3$\0005\4#\0=\4\t\3B\1\2\1K\0\1\0\1\0\0\1\0\1\venable\1\vbuffer\16guihua_rust\vguihua\15clap_input\aft\6o\bvim\fsources\1\0\1\tname\22pandoc_references\1\0\1\tname\vbuffer\1\0\1\tname\14ultisnips\1\0\1\tname\rnvim_lsp\1\0\1\tname\tpath\17experimental\1\0\2\16native_menu\1\15ghost_text\2\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-p>\21select_prev_item\n<C-n>\1\0\0\21select_next_item\fmapping\15completion\1\0\2\16completeopt\"menu,menuone,noselect,preview\19keyword_length\3\2\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: navigator.lua
time([[Config for navigator.lua]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14navigator\frequire\0", "config", "navigator.lua")
time([[Config for navigator.lua]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\23current_line_blame\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n†\2\0\0\4\0\v\0\0256\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0009\0\3\0\18\2\0\0009\0\4\0'\3\5\0B\0\3\0016\0\0\0009\0\1\0009\0\3\0\18\2\0\0009\0\4\0'\3\6\0B\0\3\0016\0\a\0'\2\b\0B\0\2\0029\0\t\0005\2\n\0B\0\2\1K\0\1\0\1\0\3\31show_current_context_start\2\25show_current_context\2\25space_char_blankline\6 \nsetup\21indent_blankline\frequire\feol:â†´\14space:â‹…\vappend\14listchars\tlist\bopt\bvim\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nc\0\1\6\0\6\1\f9\1\0\0\18\3\1\0009\1\1\0019\4\2\0\23\4\0\0049\5\2\0B\1\4\0026\2\3\0009\2\4\0025\4\5\0\18\5\1\0D\2\3\0\1\4\0\0\a()\a{}\a[]\17tbl_contains\bvim\bcol\bsub\tline\2’\1\0\1\a\0\a\2\0176\1\0\0009\1\1\0019\1\2\1)\3\0\0B\1\2\2:\1\2\0019\2\3\0\18\4\2\0009\2\4\2\23\5\0\1\22\6\1\1B\2\4\0026\3\0\0009\3\5\0035\5\6\0\18\6\2\0D\3\3\0\1\4\0\0\t(  )\t{  }\t[  ]\17tbl_contains\bsub\tline\24nvim_win_get_cursor\bapi\bvim\2\4*\0\1\2\0\2\0\a9\1\0\0\6\1\1\0X\1\2€+\1\1\0X\2\1€+\1\2\0L\1\2\0\6)\tchar*\0\1\2\0\2\0\a9\1\0\0\6\1\1\0X\1\2€+\1\1\0X\2\1€+\1\2\0L\1\2\0\6}\tchar*\0\1\2\0\2\0\a9\1\0\0\6\1\1\0X\1\2€+\1\1\0X\2\1€+\1\2\0L\1\2\0\6]\tcharé\b\1\0\r\0'\1Á\0016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0026\1\0\0'\3\1\0B\1\2\0026\2\0\0'\4\a\0B\2\2\0029\3\b\0014\5\t\0\18\6\0\0'\b\t\0'\t\t\0005\n\n\0B\6\4\2\18\b\6\0009\6\v\0069\t\f\2'\v\r\0B\t\2\0A\6\1\2\18\b\6\0009\6\v\0069\t\14\2'\v\15\0B\t\2\0A\6\1\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2>\6\1\5\18\6\0\0'\b\18\0'\t\18\0B\6\3\2\18\b\6\0009\6\v\0063\t\19\0B\6\3\2\18\b\6\0009\6\20\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\21\0063\t\22\0B\6\3\2>\6\2\5\18\6\0\0'\b\23\0'\t\24\0B\6\3\2\18\b\6\0009\6\v\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\20\0063\t\25\0B\6\3\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\21\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\26\6'\t\27\0B\6\3\2>\6\3\5\18\6\0\0'\b\23\0'\t\28\0B\6\3\2\18\b\6\0009\6\v\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\20\0063\t\29\0B\6\3\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\21\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\26\6'\t\30\0B\6\3\2>\6\4\5\18\6\0\0'\b\23\0'\t\31\0B\6\3\2\18\b\6\0009\6\v\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\20\0063\t \0B\6\3\2\18\b\6\0009\6\16\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\21\0069\t\17\2B\t\1\0A\6\1\2\18\b\6\0009\6\26\6'\t!\0B\6\3\2>\6\5\0056\6\0\0'\b\1\0B\6\2\0029\6\"\6'\b#\0B\6\2\2\18\b\6\0009\6\v\0069\t\14\2'\v$\0)\f\2\0B\t\3\0A\6\1\2>\6\6\0056\6\0\0'\b\1\0B\6\2\0029\6\"\6'\b%\0B\6\2\2\18\b\6\0009\6\v\0069\t\14\2'\v$\0)\f\2\0B\t\3\0A\6\1\2>\6\a\0056\6\0\0'\b\1\0B\6\2\0029\6\"\6'\b&\0B\6\2\2\18\b\6\0009\6\v\0069\t\14\2'\v$\0)\f\2\0B\t\3\0A\6\1\0?\6\0\0B\3\2\1K\0\1\0\6{\6[\alr\6(\rget_rule\6]\0\a ]\6}\0\a }\6)\fuse_key\0\a )\5\0\rwith_del\14with_move\0\6 \tnone\fwith_cr\a%$\27not_before_regex_check\a%%\26not_after_regex_check\14with_pair\1\3\0\0\btex\nlatex\6$\14add_rules\25nvim-autopairs.conds\24nvim-autopairs.rule\21disable_filetype\1\5\0\0\20TelescopePrompt\vguihua\16guihua_rust\15clap_input\1\0\2\rcheck_ts\2\22ignored_next_char\v[%w%.]\nsetup\19nvim-autopairs\frequire\17€€À™\4\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: numb.nvim
time([[Config for numb.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\tnumb\frequire\0", "config", "numb.nvim")
time([[Config for numb.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\fonedark\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÝ\2\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0005\4\t\0=\4\n\3=\3\v\0025\3\f\0005\4\r\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\26incremental_selection\fkeymaps\1\0\4\22scope_incremental\bgrc\21node_incremental\bgrn\21node_decremental\bgrm\19init_selection\bgnn\1\0\1\venable\2\vindent\fdisable\1\2\0\0\vpython\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\5\0\0\vpython\6c\blua\nlatex\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-startup.lua
time([[Config for nvim-startup.lua]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17nvim-startup\frequire\0", "config", "nvim-startup.lua")
time([[Config for nvim-startup.lua]], false)
-- Config for: kommentary
time([[Config for kommentary]], true)
try_loadstring("\27LJ\2\n¦\1\0\0\4\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\4\0005\3\5\0B\0\3\1K\0\1\0\1\0\1 prefer_single_line_comments\2\fdefault\23configure_language\26use_extended_mappings\22kommentary.config\frequire\0", "config", "kommentary")
time([[Config for kommentary]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-treesitter-textobjects ]]
vim.cmd [[ packadd nvim-treesitter-refactor ]]
vim.cmd [[ packadd ultisnips ]]
vim.cmd [[ packadd vim-snippets ]]
vim.cmd [[ packadd cmp-nvim-ultisnips ]]
vim.cmd [[ packadd cmp-nvim-lsp ]]
vim.cmd [[ packadd cmp-buffer ]]
vim.cmd [[ packadd cmp-path ]]
vim.cmd [[ packadd cmp-pandoc-references ]]
time([[Sequenced loading]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
