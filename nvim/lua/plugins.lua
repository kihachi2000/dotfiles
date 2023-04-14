return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    -- ファイラー
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = {"nvim-lua/plenary.nvim"},
        config = function() require("config.telescope") end
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    }


    -- 補完
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "hrsh7th/vim-vsnip-integ"
        },
        config = function()
            require("config.cmp")
            require("config.vsnip")
        end
    }


    -- 見た目系
    use {
        "nvim-treesitter/nvim-treesitter",
        requires = {"nvim-treesitter/playground"},
        run = "<cmd>TSUpdate<CR>",
        config = function() require("config.treesitter") end
    }

    -- 編集ツール
    use {
        "phaazon/hop.nvim",
        branch = "v2",
        config = function() require("config.hop") end
    }

    use {
        "cohama/lexima.vim",
        config = function() require("config.lexima") end
    }

    use {
        "kylechui/nvim-surround",
        tag = "*",
        config = function() require("config.nvim-surround") end
    }

    use {
        "williamboman/mason.nvim",
        requires = {
            "williamboman/mason-lspconfig",
            "neovim/nvim-lspconfig",
        },
        config = function() require("config.lsp") end,
        run = ":MasonUpdate"
    }

    -- 自作
    use "Kenbayashi/yash.nvim"
    use  {
        "Kenbayashi/retrieve.nvim",
        config = function() require("config.retrieve") end
    }
end)