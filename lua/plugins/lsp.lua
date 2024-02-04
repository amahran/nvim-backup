return {
    -- Mason to help installing LSP servers, DAP servers, linters & formatters
    {
        "williamboman/mason.nvim",
        config = true
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "clangd" }
        }
    },
    -- config for nvim lsp client
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- setup shall connect the server
            require'lspconfig'.clangd.setup({
                on_attach = function()
                    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover,
                        { buffer = 0, desc = "show code doc"})
                    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition,
                        { buffer = 0, desc = "jump to defintion"})
                    vim.keymap.set('n', '<leader>gp', vim.lsp.buf.declaration,
                        { buffer = 0, desc = "jump to declaration"})
                    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition,
                        { buffer = 0, desc = "jump to type definition"})
                    vim.keymap.set('n', '<leader>fr', vim.lsp.buf.references,
                        { buffer = 0, desc = "find all references"})
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,
                        { buffer = 0, desc = "rename all symbols"})
                    vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format,
                        { buffer = 0, desc = "format current buffer"})
                    vim.keymap.set('n', '<leader>gh', '<cmd>ClangdSwitchSourceHeader<cr>',
                        { buffer = 0, desc = "switch between source and header"})
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
                        { buffer = 0, desc = "go to next error/warning"})
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
                        { buffer = 0, desc = "go to previous error/warning"})
                end,
            })
        end,
    },
    -- config auto-completion
    {
        -- This is like asking everybody while typing whether they have any 
        -- suggesstion of what is about to be typed and if so, it takes this
        -- input and suggessts it in a floating window

        -- This is taken as is from lazy.vim
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
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
    },
}

