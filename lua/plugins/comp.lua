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
        "L3MON4D3/LuaSnip",
    },
    opts = function() -- this like require(plugin).setup(opts)
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
        local defaults = require("cmp.config.default")()
        return {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<S-CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<C-CR>"] = function(fallback)
                    cmp.abort()
                    fallback()
                end,
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                    { name = "buffer" },
                }),
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
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

