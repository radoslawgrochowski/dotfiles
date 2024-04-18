return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
      -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = function()
      local keybinds = {
        {
          "<leader>ccc",
          ":CopilotChat ",
          desc = "CopilotChat - Prompt",
        },
        {
          "<leader>ccc",
          ":CopilotChatVisual ",
          mode = "x",
          desc = "CopilotChat - Prompt",
        },
      }
      local prompts = {
        { prompt = "Simplify and improve readablilty.", desc = "Simplify", key = "s" },
        { prompt = "Optimize the code to improve performance and readablilty.", desc = "Optimize", key = "o" },
        { prompt = "Review the following code and provide concise suggestions.", desc = "Review", key = "r" },
        { prompt = "Find possible errors and fix them for me", desc = "Fix", key = "f" },
        { prompt = "Explain in detail.", desc = "Explain", key = "e" },
        {
          prompt = "Generate extensive unit tests. Respond with just the code and do not explain the result.",
          desc = "Test",
          key = "t",
        },
        {
          prompt = "Generate extensive unit tests using `jest` with `@testing-libary/react` when needed. "
            .. "Prefer to use global variable `screen` from `@testing-libary/react` when needed. "
            .. "Prefer to use `jest.each` when iterating over similar test cases. "
            .. "Prefer to use typescript. "
            .. "Respond with just the code and do not explain the result.",
          desc = "React",
          key = "Tr",
        },
      }
      for _, v in pairs(prompts) do
        table.insert(keybinds, {
          "<leader>cc" .. v.key,
          ":CopilotChatVisual " .. v.prompt .. "<cr>",
          mode = "x",
          desc = "CopilotChat - " .. v.desc,
          silent = true,
        })
      end
      return keybinds
    end,
  },
}
