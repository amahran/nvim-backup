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
                -- try to find the root directory of the project based on a pattern
                root_dir = function(fname)
                    return require("lspconfig.util").root_pattern(
                        "Makefile",
                        "configure.ac",
                        "configure.in",
                        "config.h.in",
                        "meson.build",
                        "meson_options.txt",
                        "build.ninja"
                    )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
                            fname
                        ) or require("lspconfig.util").find_git_ancestor(fname)
                end,
                on_attach = function(_,bufn)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                        { buffer = bufn, desc = "show code doc"})
                    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition,
                        { buffer = bufn, desc = "jump to defintion"})
                    vim.keymap.set('n', '<leader>gp', vim.lsp.buf.declaration,
                        { buffer = bufn, desc = "jump to declaration"})
                    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition,
                        { buffer = bufn, desc = "jump to type definition"})
                    vim.keymap.set('n', '<leader>fr', vim.lsp.buf.references,
                        { buffer = bufn, desc = "find all references"})
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,
                        { buffer = bufn, desc = "rename all symbols"})
                    vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format,
                        { buffer = bufn, desc = "format current buffer"})
                    vim.keymap.set('n', '<leader>gh', '<cmd>ClangdSwitchSourceHeader<cr>',
                        { buffer = bufn, desc = "switch between source and header"})
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
                        { buffer = bufn, desc = "go to next error/warning"})
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
                        { buffer = bufn, desc = "go to previous error/warning"})
                    vim.keymap.set('n', '<leader>de', vim.diagnostic.enable,
                        { desc = "enable diagnostics" })
                    vim.keymap.set('n', '<leader>dd', vim.diagnostic.disable,
                        { desc = "disable diagnostics" })
                end,
            })
        end,
    },
}

