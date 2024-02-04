require("config.maps")
require("config.opts")
require("config.lazy")

-- the clear flag seems to be important to clear the autocmd everytime before it gets executed
local group = vim.api.nvim_create_augroup("elprof", { clear = true })

-- NOBODY every wants trailing spaces
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
