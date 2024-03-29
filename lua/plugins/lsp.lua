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
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=never",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    '-j=4',
                    '--log=verbose',
                },
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
                    vim.keymap.set('n', '<leader>de', vim.diagnostic.enable,
                        { desc = "enable diagnostics" })
                    vim.keymap.set('n', '<leader>dd', vim.diagnostic.disable,
                        { desc = "disable diagnostics" })
                end,
            })
        end,
    },
}

