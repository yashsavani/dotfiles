-- PACKER BOOTSTRAP
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    execute "packadd packer.nvim"
end

-- PLUGIN CONFIGURATION
require("pluginlist")
vim.cmd "runtime macros/sandwich/keymap/surround.vim"

-- SETTINGS
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then scopes["o"][key] = value end
end

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
if vim.env.CONDA_PREFIX then
    vim.g.python3_host_prog = vim.env.CONDA_PREFIX .."/bin/python"
else
    vim.g.python3_host_prog = "/usr/local/anaconda3/bin/python"
end

opt("o", "termguicolors", true) -- set term gui colors most terminals support this.
opt("o", "background", "dark") -- Dark Background
vim.cmd [[colorscheme onedark]]
vim.g.onedark_terminal_italics = 2

vim.g.vimwiki_list = { { path = "~/dev/brain", syntax = "markdown", ext = ".md" } }
vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".markdown"] = "markdown", [".mdown"] = "markdown" }
vim.g.vimwiki_markdown_link_ext = 1
vim.g.vimwiki_table_mappings = 0

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
opt("w", "foldminlines", 10)

-- KEY-MAPPINGS
local noremap_silent = { noremap = true, silent = true }
local noremap_silent_expr = { noremap = true, silent = true, expr = true }
local map = vim.api.nvim_set_keymap

--Remap for dealing with word wrap
map('n', 'k', [[v:count == 0 ? 'gk' : 'k']], noremap_silent_expr)
map('n', 'j', [[v:count == 0 ? 'gj' : 'j']], noremap_silent_expr)

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
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

-- Quick save.
map("n", "<Leader>s", [[:w<CR>]], noremap_silent)

-- Quick exit.
map("n", "<Leader>q", [[:q<CR>]], noremap_silent)
map("n", "<Leader>x", [[:close<CR>]], noremap_silent)

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
map("n", "<Leader><Space>", [[<cmd>lua require('telescope.builtin').buffers()<cr>]], noremap_silent)
map("n", "<Leader>ff", [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<cr>]], noremap_silent)
map("n", "<Leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], noremap_silent)
map("n", "<Leader>fh", [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], noremap_silent)

-- Neogit keymaps.
map("n", "<Leader>gg", [[:lua require("neogit").open({ kind = "vsplit" })<cr>]], noremap_silent)
map("n", "<Leader>gc", [[:lua require("neogit").open({ "commit" })<cr>]], noremap_silent)

-- Spelling
map("i", "<C-s>", [[<C-g>u<Esc>[s1z=`]a<C-g>u]], noremap_silent)
map("n", "<C-s>", [[[s1z=<C-o>]], noremap_silent)

-- Trouble keymaps.
map("n", "<Leader>dt", [[:TroubleToggle<CR>]], noremap_silent)
map("n", "<Leader>dw", [[:TroubleToggle lsp_workspace_diagnostics<CR>]], noremap_silent)
map("n", "<Leader>dd", [[:TroubleToggle lsp_document_diagnostics<CR>]], noremap_silent)
map("n", "<Leader>dq", [[:TroubleToggle quickfix<CR>]], noremap_silent)
map("n", "<Leader>dl", [[:TroubleToggle loclist<CR>]], noremap_silent)
map("n", "<Leader>dr", [[:TroubleToggle lsp_references<CR>]], noremap_silent)
map("n", "<Leader>dx", [[:cclose<CR>]], noremap_silent)
map("n", "gR", [[:TroubleToggle lsp_references<CR>]], noremap_silent)

-- QuickFix list
map("n", "<C-j>", [[:cnext<CR>]], noremap_silent)
map("n", "<C-k>", [[:cprev<CR>]], noremap_silent)

-- LSPSaga keymaps.
map("n", "<Leader>e", [[:lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>]], noremap_silent)
map("n", "[e", [[:lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>]], noremap_silent)
map("n", "]e", [[:lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>]], noremap_silent)

-- LSP keymaps.
map("n", "<Leader>la", [[:lua require("lspsaga.codeaction").code_action()<CR>]], noremap_silent)
map("v", "<Leader>la", [[:<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>]], noremap_silent)
map("n", "<Leader>ld", [[:Telescope lsp_document_diagnostics<CR>]], noremap_silent)
map("n", "<Leader>lw", [[:Telescope lsp_workspace_diagnostics<CR>]], noremap_silent)
map("n", "<Leader>lf", [[:lua vim.lsp.buf.formatting()<CR>]], noremap_silent)
map("n", "<Leader>lh", [[:lua require("lspsaga.hover").render_hover_doc()<CR>]], noremap_silent)
map("n", "<Leader>lI", [[:LspInfo<CR>]], noremap_silent)
map("n", "<Leader>ll", [[:lua require"lspsaga.provider".lsp_finder()<CR>]], noremap_silent)
map("n", "<Leader>lp", [[:lua require"lspsaga.provider".preview_definition()<CR>]], noremap_silent)
map("n", "<Leader>lq", [[:Telescope quickfix<CR>]], noremap_silent)
map("n", "<Leader>lr", [[:lua require("lspsaga.rename").rename()<CR>]], noremap_silent)
map("n", "<Leader>lt", [[:lua vim.lsp.buf.type_definition()<CR>]], noremap_silent)
map("n", "<Leader>lx", [[:cclose<CR>]], noremap_silent)
map("n", "<Leader>lsd", [[:Telescope lsp_document_symbols<CR>]], noremap_silent)
map("n", "<Leader>lsw", [[:Telescope lsp_dynamic_workspace_symbols<CR>]], noremap_silent)

-- Nvim IPy
vim.api.nvim_exec([[
  command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True")
  let g:ipy_celldef = '^##' " regex for cell start and end
  let g:nvim_ipy_perform_mappings = 0

  nmap <silent> <leader>jqt :RunQtConsole<Enter>
  nmap <silent> <leader>jk :IPython<Space>--existing<Space>--no-window<Enter>
  nmap <silent> <leader>jc <Plug>(IPy-RunCell)
  nmap <silent> <leader>ja <Plug>(IPy-RunAll)
]], false)

-- Autocommands
vim.cmd "filetype plugin indent on"
vim.api.nvim_exec([[
  au BufEnter term://* setlocal nonumber | setlocal norelativenumber | set laststatus=0
  au BufRead,BufNewFile *.lua set formatoptions-=cro
  au Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 foldmethod=indent
  au FileType gitcommit setlocal spell
]], false)
