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
        'glepnir/lspsaga.nvim',
        config = function() require'lspsaga'.init_lsp_saga() end
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end
    }

    -- Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        config = function() require"plugins.cmp_config" end
    }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }

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
        config = function() require("gitsigns").setup{current_line_blame = true} end
    }
    -- use {
    --     'TimUntersberger/neogit',
    --     requires = 'nvim-lua/plenary.nvim',
    --     config = function() require("neogit").setup() end
    -- }

    -- Terminal
    use {
        "akinsho/toggleterm.nvim",
        config = function() require"toggleterm".setup{open_mapping = [[<C-\>]]} end
    }

    -- Miscellaneous
    use {
        'lewis6991/spellsitter.nvim',
        config = function() require('spellsitter').setup() end
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
    use {
        "windwp/nvim-autopairs",
        config = function() require("plugins.autopairs") end
    }
    use {
        "henriquehbr/nvim-startup.lua",
        config = function() require("nvim-startup").setup() end
    }
    use 'nacro90/numb.nvim'
    use "lukas-reineke/indent-blankline.nvim"
    use "machakann/vim-sandwich"
    use {
        "folke/which-key.nvim",
        config = function() require("which-key").setup {} end
    }
    -- use 'ggandor/lightspeed.nvim'
    use 'justinmk/vim-sneak'
    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use {'kevinhwang91/nvim-bqf', ft="qf"}
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require"lualine".setup{options={theme = "onedark"}}end
    }
    -- use {
    --     "wfxr/minimap.vim",
    --     run = ':!cargo install --locked code-minimap'
    -- }
    use "monaqa/dial.nvim"
    use "vimwiki/vimwiki"
    use "jbyuki/nabla.nvim"
    use "bfredl/nvim-ipy"
    -- use "lervag/vimtex"
    use "simrat39/symbols-outline.nvim"

end, { display = { border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" } } })
