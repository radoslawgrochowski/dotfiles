vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require 'nvim-tree'.setup {
    sync_root_with_cwd  = true,
    respect_buf_cwd     = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    disable_netrw       = true,
    hijack_netrw        = true,
    hijack_directories  = {
        enable = true,
        auto_open = true,
    },
    diagnostics         = {
        enable = true,
        show_on_dirs = true,
    },
    actions             = {
        open_file = {
            quit_on_open = true,
            resize_window = true,
        },
    },
}

vim.keymap.set("n", "<leader>N", ":NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", { silent = true })
