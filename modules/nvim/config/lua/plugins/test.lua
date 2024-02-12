return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-neotest/neotest-jest",
        config = function()
          require("neotest-jest").is_test_file = function(file_path)
            for _, x in ipairs({ "spec", "test", "unit" }) do
              for _, ext in ipairs({ "js", "jsx", "ts", "tsx" }) do
                if string.match(file_path, "%." .. x .. "%." .. ext .. "$") then
                  return true
                end
              end
            end
            return false
          end
        end,
      },
    },

    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test -- --no-watch --no-watchAll",
          env = { IS_CI = true },
          cwd = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src")
            end
            return vim.fn.getcwd()
          end,
        },
      },
      discovery = { enabled = false },
    },

    keys = function()
      return {
        {
          "<leader>tf",
          function()
            require("neotest").run.run(vim.fn.expand("%"))
          end,
          desc = "Test File",
        },
        {
          "<leader>tn",
          function()
            require("neotest").run.run()
          end,
          desc = "Test Nearest",
        },
        {
          "<leader>ts",
          function()
            require("neotest").summary.toggle()
          end,
          desc = "Toggle Test Summary",
        },
        {
          "<leader>to",
          function()
            require("neotest").output.open({ enter = true, auto_close = true })
          end,
          desc = "Show Test Output",
        },
        {
          "<leader>tO",
          function()
            require("neotest").output_panel.toggle()
          end,
          desc = "Toggle Output Panel",
        },
        {
          "<leader>tS",
          function()
            require("neotest").run.stop()
          end,
          desc = "Stop",
        },
        -- {
        --   "<leader>tT",
        --   function()
        --     require("neotest").run.stop(vim.loop.cwd())
        --     require("neotest").run.run(vim.loop.cwd())
        --     require("neotest").run.attach(vim.loop.cwd())
        --   end,
        --   desc = "Run all",
        -- },
        {
          "<leader>ta",
          function()
            require("neotest").run.attach()
          end,
          desc = "Attach",
        },
        {
          "<leader>tl",
          function()
            require("neotest").run.run_last()
          end,
          desc = "Re-run last test",
        },

        -- {
        --   "<leader>tw",
        --   function()
        --     require("neotest").watch()
        --   end,
        --   desc = "Watch",
        -- },
        -- {
        --   "<leader>tr",
        --   function()
        --     require("neotest").run.run({
        --       jestCommand = "npm test -- --no-watch --no-watchAll --findRelatedTests " .. vim.fn.expand("%"),
        --       env = { IS_CI = "true" },
        --     })
        --     require("neotest").run.attach()
        --   end,
        --   desc = "Test related",
        -- },
      }
    end,
  },
}
