-- PACKER PLUGINS
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    use {
        "b3nj5m1n/kommentary",
        config = function()
            require"kommentary.config".use_extended_mappings()
            require"kommentary.config".configure_language("default", {
                prefer_single_line_comments = true,
            })
        end
    }
    use "joshdick/onedark.vim"
    use { "romgrk/barbar.nvim", requires = "kyazdani42/nvim-web-devicons" }
    use {
        "hoob3rt/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require "lualine".setup { options = { theme = "onedark" } }
        end
    }
    use {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require"nvim-tree".setup {} end
    }
    use { "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" }
    use { "nacro90/numb.nvim", config = function() require"numb".setup {} end }
    use "monaqa/dial.nvim"
    use {
        "machakann/vim-sandwich",
        config = function()
            vim.cmd "runtime macros/sandwich/keymap/surround.vim"
        end
    }
    use "justinmk/vim-sneak"
    -- use "ggandor/lightspeed.nvim"
    -- use {
    --     "henriquehbr/nvim-startup.lua",
    --     config = function() require"nvim-startup".setup {} end
    -- }
    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("gitsigns").setup { current_line_blame = true }
        end
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require "nvim-treesitter.configs".setup {
                ensure_installed = { "python", "c", "lua", "latex", "bash" },
                highlight = { enable = true },
                indent = { enable = true, disable = {"python", } },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
            }
        end
    }
    use { "nvim-treesitter/nvim-treesitter-textobjects", after="nvim-treesitter" }
    use { "nvim-treesitter/nvim-treesitter-refactor" , after="nvim-treesitter" }
    use { "lukas-reineke/indent-blankline.nvim", config = function() require("ibl").setup {} end }
    use "neovim/nvim-lspconfig"
    use {
        "ray-x/navigator.lua",
        requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
        config = function() require("navigator").setup {
            keymaps = { { mode = 'i', key = '<C-K>', func = vim.lsp.buf.signature_help, desc = 'signature_help' }}
        } end
    }
    use {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require"cmp"
            cmp.setup({
                snippet = {
                    expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end,
                },
                completion = {
                    completeopt = "menu,menuone,noselect,preview",
                    keyword_length = 2,
                },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                },
                experimental = {
                    native_menu = false,
                    ghost_text = true,
                },
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "ultisnips" },
                    { name = "buffer" },
                    { name = "pandoc_references" },
                },
            })
            if vim.o.ft == "clap_input" and vim.o.ft == "guihua" and vim.o.ft == "guihua_rust" then
                cmp.setup.buffer { completion = {enable = false} }
            end
        end
    }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "jc-doyle/cmp-pandoc-references", after = "nvim-cmp" }
    use { "SirVer/ultisnips", after = "nvim-cmp" } 
    use { "quangnguyen30192/cmp-nvim-ultisnips", after = "ultisnips" } 
    use { "honza/vim-snippets", after = "ultisnips" } 
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup{
            check_ts = true,
            disable_filetype = { "TelescopePrompt" , "guihua", "guihua_rust", "clap_input" },
            ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
            }
            local Rule = require("nvim-autopairs.rule")
            local npairs = require("nvim-autopairs")
            local cond = require("nvim-autopairs.conds")

            npairs.add_rules {
            Rule("$", "$",{"tex", "latex"})
                -- don't add a pair if the next character is %
                :with_pair(cond.not_after_regex_check("%%"))
                -- don't add a pair if  the previous character is $
                :with_pair(cond.not_before_regex_check("%$"))
                -- disable add newline when press <cr>
                :with_cr(cond.none()),
            Rule(" ", " ")
                :with_pair(function(opts)
                local pair = opts.line:sub(opts.col -1, opts.col)
                return vim.tbl_contains({ "()", "{}", "[]" }, pair)
                end)
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(function(opts)
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local context = opts.line:sub(col - 1, col + 2)
                return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
                end),
            Rule("", " )")
                :with_pair(cond.none())
                :with_move(function(opts) return opts.char == ")" end)
                :with_cr(cond.none())
                :with_del(cond.none())
                :use_key(")"),
            Rule("", " }")
                :with_pair(cond.none())
                :with_move(function(opts) return opts.char == "}" end)
                :with_cr(cond.none())
                :with_del(cond.none())
                :use_key("}"),
            Rule("", " ]")
                :with_pair(cond.none())
                :with_move(function(opts) return opts.char == "]" end)
                :with_cr(cond.none())
                :with_del(cond.none())
                :use_key("]"),
            require"nvim-autopairs".get_rule("(")
                :with_pair(cond.not_before_regex_check("lr", 2)),
            require"nvim-autopairs".get_rule("[")
                :with_pair(cond.not_before_regex_check("lr", 2)),
            require"nvim-autopairs".get_rule("{")
                :with_pair(cond.not_before_regex_check("lr", 2)),
            }
        end
    }
    use { "Vimjas/vim-python-pep8-indent" }
    use { "github/copilot.vim" }
--     use {
--         "folke/which-key.nvim",
--         config = function() require("which-key").setup {} end
--     }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- SETTINGS
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then scopes["o"][key] = value end
end

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
if vim.env.CONDA_PREFIX then
    vim.g.python3_host_prog = vim.env.CONDA_PREFIX .. "/bin/python"
else
    vim.g.python3_host_prog = "/usr/local/Caskroom/miniconda/base/bin/python"
end

opt("o", "termguicolors", true) -- set term gui colors most terminals support this.
opt("o", "background", "dark") -- Dark Background
-- vim.cmd [[colorscheme onedark]]
vim.g.onedark_terminal_italics = 2

vim.g.tex_flavor = "latex"

vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.formatoptions = vim.o.formatoptions:gsub("cro", "") -- Stop extending comments

opt("o", "encoding", "utf-8") -- Set encoding.
opt("o", "fileencoding", "utf-8") -- Set encoding written to file.
opt("o", "inccommand", "nosplit") -- Show effect of a command in realtime.
opt("o", "hlsearch", true) -- Highlight search
opt("w", "number", true) -- Line numbers.
opt("w", "relativenumber", true) -- Relative line numbers.
opt("o", "hidden", true) -- Allow background buffers.
opt("o", "mouse", "a") -- Enable mouse.
opt("o", "breakindent", true) -- Enable break indent
opt("o", "ignorecase", true) -- Case insensitive matching
opt("o", "smartcase", true) -- Search smartly.
opt("o", "updatetime", 250) -- Faster completion.
opt("w", "signcolumn", "yes") -- Always show the signcolumn, otherwise it would shift the text each time.
opt("o", "cmdheight", 2) -- More space for displaying messages.
opt("o", "splitbelow", true) -- Horizontal splits will automatically be below.
opt("o", "splitright", true) -- Vertical splits will automatically be to the right.
opt("o", "pumblend", 10) -- Enables transparency of popup menu.
opt("o", "pumheight", 15) -- Makes popup menu smaller.
opt("o", "ruler", true) -- Show cursor position.
opt("o", "incsearch", true) -- Search in real-time.
opt("o", "scrolloff", 5) -- Keep 5 lines between cursor and vertical edges of window.
opt("o", "showmatch", true) -- Show matching brackets.
opt("o", "showtabline", 2) -- Always show tab line.
opt("b", "swapfile", false) -- No swapfile.
opt("o", "title", true) -- Set title.
opt("b", "tabstop", 4) -- Set tabstop to 4.
opt("b", "shiftwidth", 4) -- Set tabstop to 4.
opt("o", "smarttab", true) -- Makes tabbing smarter.
opt("b", "expandtab", true) -- Converts tabs to spaces.
opt("o", "autoindent", true) -- Inherit indenting.
opt("b", "autoread", true) -- Automatically update changes.
opt("b", "smartindent", true) -- Makes indenting smart.
opt("o", "shiftround", true) -- Round indent to multiples of 4.
opt("o", "showtabline", 2) -- Always show tabs.
opt("o", "timeoutlen", 500) -- Default is much longer at 1000ms.
opt("o", "completeopt", "menu,menuone,noselect") -- To allow compe
opt("o", "lazyredraw", true)
-- opt("o", "foldmethod", "expr")
-- opt("w", "foldexpr", "nvim_treesitter#foldexpr()")
-- opt("w", "foldminlines", 10)
opt("w", "linebreak", true)

-- KEY-MAPPINGS
local noremap_silent = { noremap = true, silent = true }
local noremap_silent_expr = { noremap = true, silent = true, expr = true }
local map = vim.api.nvim_set_keymap

--Remap for dealing with word wrap
map("n", "k", [[v:count == 0 ? "gk" : "k"]], noremap_silent_expr)
map("n", "j", [[v:count == 0 ? "gj" : "j"]], noremap_silent_expr)

-- Highlight on yank
vim.api.nvim_exec(
    [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]   ,
    false
)

-- Y yank until the end of line  (note: this is now a default on master)
map("n", "Y", [[y$]], noremap_silent)

-- Open this file fast
map("n", "<Leader>v", [[:e $MYVIMRC<cr>]], noremap_silent)
map("n", "<Leader>z", [[:e ~/.zshrc<cr>]], noremap_silent)

-- Toggle highlights.
map("n", "<Leader>h", [[:set hlsearch!<CR>]], noremap_silent)

-- Better escapes.
map("i", "jk", [[<Esc>]], noremap_silent)
map("c", "jk", [[<C-C>]], noremap_silent)

-- Better window navigation.
map("n", "<C-h>", [[<C-w>h]], noremap_silent)
map("n", "<C-j>", [[<C-w>j]], noremap_silent)
map("n", "<C-l>", [[<C-w>l]], noremap_silent)
map("n", "<C-k>", [[<C-w>k]], noremap_silent)

-- Better indentation.
map("v", "<", [[<gv]], noremap_silent)
map("v", ">", [[>gv]], noremap_silent)

-- Paste without replacing clipboard
map("n", "<Leader>p", [["_dP]], noremap_silent)

-- Switch buffer.
map("n", "<Leader><TAB>", [[:BufferNext<CR>]], noremap_silent) -- TAB in normal mode will move to the next buffer.
map("n", "<Leader><S-TAB>", [[:BufferPrevious<CR>]], noremap_silent) -- SHIFT + TAB in normal mode will move to prev buffer.
map("n", "<Leader>w", [[:BufferClose<CR>]], noremap_silent)

-- Move selected line / block of text in visual mode.
map("x", "K", [[:move '<-2<CR>gv-gv]], noremap_silent)
map("x", "J", [[:move '>+1<CR>gv-gv]], noremap_silent)
map("n", "<A-k>", [[:move -2<CR>==]], noremap_silent)
map("n", "<A-j>", [[:move +<CR>==]], noremap_silent)

-- Shortcuts.
map("n", "<Leader>s", [[:w<CR>]], noremap_silent)
map("n", "<Leader>q", [[:q<CR>]], noremap_silent)
map("n", "<Leader>x", [[:close<CR>]], noremap_silent)
map("n", "<Leader>m", [[:make<CR><CR>]], noremap_silent)

-- Emacs-like
map("i", "<C-e>", [[<Esc>A]], noremap_silent)
map("i", "<C-a>", [[<Esc>I]], noremap_silent)
map("i", "<C-f>", [[<Right>]], noremap_silent)
map("i", "<C-b>", [[<Left>]], noremap_silent)
map("i", "<C-p>", [[<Up>]], noremap_silent)
map("i", "<C-n>", [[<Down>]], noremap_silent)

-- nvim-tree keymaps.
map("n", "<C-n>", [[:lua require("nvim-tree").toggle()<CR>]], noremap_silent)

-- Telescope keymaps.
map("n", "<Leader><Space>", [[<cmd>lua require("telescope.builtin").find_files({previewer = false})<cr>]], noremap_silent)
map("n", "<Leader>fb", [[<cmd>lua require("telescope.builtin").buffers()<cr>]], noremap_silent)
map("n", "<Leader>fg", [[<cmd>lua require("telescope.builtin").live_grep()<cr>]], noremap_silent)
map("n", "<Leader>fh", [[<cmd>lua require("telescope.builtin").help_tags()<cr>]], noremap_silent)
map("n", "<Leader>fo", [[<cmd>lua require("telescope.builtin").oldfiles()<cr>]], noremap_silent)
map("n", "<Leader>fs", [[<cmd>lua require("telescope.builtin").spell_suggest()<cr>]], noremap_silent)
map("n", "<Leader>fq", [[<cmd>lua require("telescope.builtin").quickfix()<cr>]], noremap_silent)

-- Git keymaps.
-- map("n", "<Leader>gg", [[:lua require("neogit").open({ kind = "vsplit" })<cr>]], noremap_silent)
-- map("n", "<Leader>gc", [[:lua require("neogit").open({ "commit" })<cr>]], noremap_silent)
map("n", "<Leader>hp", [[:Gitsigns preview_hunk<cr>]], noremap_silent)

-- Spelling
map("i", "<C-s>", [[<C-g>u<Esc>[s1z=`]a<C-g>u]], noremap_silent)
map("n", "<C-s>", [[[s1z=<C-o>]], noremap_silent)

-- QuickFix list
map("n", "<C-j>", [[:cnext<CR>]], noremap_silent)
map("n", "<C-k>", [[:cprev<CR>]], noremap_silent)

-- Ultisnips Edit
map("n", "<Leader>es", [[:UltiSnipsEdit<CR>]], noremap_silent)


-- Autocommands
vim.api.nvim_exec([[
  colorscheme onedark
  filetype plugin indent on
  au BufEnter term://* setlocal nonumber | setlocal norelativenumber | set laststatus=0
  au BufRead,BufNewFile *.lua set formatoptions-=cro
  au Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 autoindent foldmethod=indent
  au FileType gitcommit setlocal spell
]], false)
