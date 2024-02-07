-- plugins spec with no much configuration
return {
    -- THE POPE
    {
        "tpope/vim-commentary",
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end,
    },
    {
        -- The one and only THEPRIMEAGEN
        "ThePrimeagen/harpoon",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<S-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<S-j>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<S-k>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<S-l>", function() ui.nav_file(5) end)
        end,
    },
    {
        "folke/neoconf.nvim", cmd = "Neoconf"
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        -- if non of this is called, setup will not be called,
        -- which means the plugin will not be initialized and it will wait for
        -- a call to `:Neotree` to actually work
        -- I think it's a good idea to call opts for plugin options and configurations
        -- and do keymaps that is related to the plugin within the config function
        --
        -- opts = {
        --     vim.keymap.set('n', '<leader>pv', '<cmd>Neotree toggle<CR>', {desc = "start neotree"})
        -- }, -- Same as config = true, same as require("neo-tree.setup({})")
        -- config = true,
        config = function()
            require("neo-tree").setup()
            vim.keymap.set('n', '<leader>pv', '<cmd>Neotree toggle<CR>', {desc = "start neotree"})
        end,
        --
        -- start only with a keymap
        -- keys = {
        --   { "<leader>pv", "<cmd>Neotree toggle<cr>", desc = "neotree" },
        -- },
        --
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "markdown", "doxygen", "make" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    }
}
