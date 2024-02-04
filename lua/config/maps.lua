local map = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map.set("n", "<leader>pv", vim.cmd.Ex)

map.set("v", "J", ":m '>+1<CR>gv=gv")
map.set("v", "K", ":m '<-2<CR>gv=gv")

map.set("n", "J", "mzJ`z") -- keep the cursor in place when joining lines

-- always keep the cursor in the middle when half page scrolling
-- or navigating between the search hits
map.set("n", "<C-d>", "<C-d>zz")
map.set("n", "<C-u>", "<C-u>zz")
-- allow search terms to stay in the middle
map.set("n", "n", "nzzzv") -- zv -> expands any folds when the cursor is there
map.set("n", "N", "Nzzzv")

-- greatest remap ever
-- keep the yank register when pasting text over selected text and don't replace
-- it with the deleted text
map.set("x", "<leader>p", [["_dP]]) -- x for cahracter wise visual mode (enabled
-- with v), and v is for all visual modes (v, V, <C-v>)

-- next greatest remap ever : asbjornHaland
-- yank to the + register (the system clipboard)
map.set({"n", "v"}, "<leader>y", [["+y]])
map.set("n", "<leader>Y", [["+Y]]) -- Y is same as yy

-- delete to the void register so not saved anywhere
map.set({"n", "v"}, "<leader>d", [["_d]])

map.set("n", "Q", "<nop>")
map.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- quick fix navigating
-- TODO: figure out a consistent keymaps
map.set("n", "<C-n>", "<cmd>cnext<CR>zz")
map.set("n", "<C-p>", "<cmd>cprev<CR>zz")
map.set("n", "<leader>k", "<cmd>lnext<CR>zz")
map.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace the word under the cusrsor command
map.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- make the file of the current buffer executable
map.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

map.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- remove the highlighted search
map.set("n", "<c-l>", ":<c-u>nohlsearch<cr><c-l>")
-- quality of life, although not so much needed with telescope around
vim.api.nvim_set_keymap('c', '%%', [[(vim.fn.getcmdtype() == ':' and vim.fn.expand('%:h').'/' or '%%')]], { noremap = true, expr = true })
