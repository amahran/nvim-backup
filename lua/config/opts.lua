local opt = vim.opt

opt.guicursor = ""
opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- save undofile(s) in this path
opt.undofile = true -- keep undo file across vim sessions

opt.hlsearch = true
opt.incsearch = true
-- opt.ignorecase = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes" -- this is a column in the left side to show signs like a breakpoint for example
opt.isfname:append("@-@") -- add @ as a valid character if it does appear in a file name

opt.updatetime = 50 -- write the swap file to disk 50 msec after the last keystroke in insert mode -> helpful for recovery 
-- not sure if this of any help bacause the swapfile is disabled 
-- however undotree might be used for this purpose instead of swap

opt.colorcolumn = "80"

