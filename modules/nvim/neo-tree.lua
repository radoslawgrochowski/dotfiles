vim.keymap.set("n", "<leader>N", ":Neotree toggle reveal<CR>", { silent = true })
vim.keymap.set("n", "<leader>n", ":Neotree toggle reveal<CR>", { silent = true })


require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["o"] = "system_open",
      },
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- macOs: open file in default application in the background.
        -- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
        vim.api.nvim_command("silent !open -g " .. path)
        -- Linux: open file in default application
        vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
      end,
    },
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function()
        --auto close
        require("neo-tree").close_all()
      end
    },
  }
})
