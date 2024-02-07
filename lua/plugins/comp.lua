return {
    -- config auto-completion
    -- This is like asking everybody while typing whether they have any
    -- suggesstion of what is about to be typed and if so, it takes this
    -- input and suggessts it in a floating window

    -- This is taken as is from lazy.vim
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter", -- load when entering insert mode
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",     -- get the completion from the lsp
        "hrsh7th/cmp-buffer",       -- completion by gussing from the current buffer
        "hrsh7th/cmp-path",         -- completes paths
        "hrsh7th/cmp-nvim-lua",     -- helpful for lua develeopment - like writing this configurations
        "saadparwaiz1/cmp_luasnip", -- get completion from the luasnip plugin
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
            dependencies = {
                "rafamadriz/friendly-snippets"
           },
            config = function()
                local ls = require('luasnip')
                -- TODO: not sure what is this?
                vim.keymap.set({"i"}, "<C-s>k", function() ls.expand() end, {silent = true})
                vim.keymap.set({"i", "s"}, "<C-s>l", function() ls.jump( 1) end, {silent = true})
                vim.keymap.set({"i", "s"}, "<C-s>h", function() ls.jump(-1) end, {silent = true})

                -- this moves to outer expandstions if nested functions for example
                vim.keymap.set({"i", "s"}, "<C-s>e", function()
                    if ls.choice_active() then
                        ls.change_choice(1)
                    end
                end, {silent = true})
            end,
        },
        "onsails/lspkind.nvim",
    },
    opts = function() -- this like require(plugin).setup(opts)
        -- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
        local defaults = require("cmp.config.default")()
        local lspkind = require("lspkind")
        return {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = "menu,menuone,noselect",
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.select }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.select }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- invoke completion menu
                ["<C-e>"] = cmp.mapping.abort(), -- remove the completion menu
                ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<S-y>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            -- The order of the sources, will dictate the order in the auto-completion menu
            sources = cmp.config.sources({
                { name = "nvim_lua" },
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "luasnip" },
                { name = "buffer", keyword_length = 5 },
            }),
            formatting = {
                format = lspkind.cmp_format {
                    with_text = true,
                    menu = {
                        buffer = "[buf]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[api]",
                        path = "[path]",
                        luasnip = "[snip]",
                    },
                },
            },
            experimental = {
                -- kind of annoying and in the way
                -- ghost_text = {
                --     hl_group = "CmpGhostText",
                -- },
            },
            sorting = defaults.sorting,
        }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
        for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
        end
        require("cmp").setup(opts)

        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
        require('lspconfig')['clangd'].setup {
            capabilities = capabilities
        }
    end,
}

