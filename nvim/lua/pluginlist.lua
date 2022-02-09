local packer = require("packer") local use = packer.use

packer.init({
    display = { open_cmd = "leftabove 80vnew [packer]" },
    profile = { enable = true, threshold = 1 },
})

return packer.startup(function()
    -- Packer can manage itself.
    use "wbthomason/packer.nvim"

    -- Theme
    use "joshdick/onedark.vim"

    -- LSP
    use 'neovim/nvim-lspconfig'
    use {
        'williamboman/nvim-lsp-installer',
        config = function() require"plugins.lspconfig" end
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end
    }
    use {
        'ray-x/navigator.lua',
        requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'},
        config = function () require("navigator").setup {} end
    }
    -- use { "ray-x/lsp_signature.nvim"}

    -- Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        config = function() require"plugins.cmp_config" end
    }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "jc-doyle/cmp-pandoc-references", after = "nvim-cmp" }

    -- Snippets
    use "SirVer/ultisnips"
    use "quangnguyen30192/cmp-nvim-ultisnips"
    use "honza/vim-snippets"

    -- TreeSitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function() require"plugins.treesitter" end,
        run = ":TSUpdate"
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'
    use { 'nvim-treesitter/nvim-treesitter-refactor' }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    -- Explorer
    use {
        "kyazdani42/nvim-tree.lua",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup{} end
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require("gitsigns").setup{ current_line_blame = true } end
    }

    -- Terminal
    use {
        "akinsho/toggleterm.nvim",
        config = function()
            require"toggleterm".setup{open_mapping = [[<C-\>]]}
            local Terminal  = require('toggleterm.terminal').Terminal
            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
            function _lazygit_toggle() lazygit:toggle() end
            vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
        end
    }

    -- Status lines
    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require"lualine".setup{options={theme = "onedark"}} end
    }

    -- Miscellaneous
    -- Working
    use {
        "windwp/nvim-autopairs",
        config = function() require("plugins.autopairs") end
    }
    use 'justinmk/vim-sneak'
    -- use 'ggandor/lightspeed.nvim'
    use {
        'nacro90/numb.nvim',
        config = function() require('numb').setup() end
    }
    use "machakann/vim-sandwich"
    use {
        "folke/which-key.nvim",
        config = function() require("which-key").setup {} end
    }
    use "monaqa/dial.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use {
        "henriquehbr/nvim-startup.lua",
        config = function() require("nvim-startup").setup() end
    }
    use {
        'b3nj5m1n/kommentary',
        config = function()
            require("kommentary.config").use_extended_mappings()
            require("kommentary.config").configure_language("default", {
                prefer_single_line_comments = true,
            })
        end
    }
    use {'kevinhwang91/nvim-bqf', ft="qf"}
    use "bfredl/nvim-ipy"

    -- Unsure
    use {
        'lewis6991/spellsitter.nvim',
        config = function() require('spellsitter').setup {enable=true} end
    }

end, { display = { border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" } } })
