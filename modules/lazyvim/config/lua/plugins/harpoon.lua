return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      {
        "<Tab>a",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Mark file with harpoon",
      },
      {
        "<Tab>j",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Select first mark",
      },
      {
        "<Tab>J",
        function()
          require("harpoon"):list():replace_at(1)
        end,
        desc = "Replace first mark",
      },
      {
        "<Tab>h",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Select first mark",
      },
      {
        "<Tab>H",
        function()
          require("harpoon"):list():replace_at(1)
        end,
        desc = "Replace first mark",
      },
      {
        "<Tab>j",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Select first mark",
      },
      {
        "<Tab>J",
        function()
          require("harpoon"):list():replace_at(2)
        end,
        desc = "Replace first mark",
      },
      {
        "<Tab>k",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Select first mark",
      },
      {
        "<Tab>K",
        function()
          require("harpoon"):list():replace_at(3)
        end,
        desc = "Replace first mark",
      },
      {
        "<Tab>l",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Select first mark",
      },
      {
        "<Tab>L",
        function()
          require("harpoon"):list():replace_at(4)
        end,
        desc = "Replace first mark",
      },
      {
        "<Tab>;",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "Select first mark",
      },
      {
        "<Tab>:",
        function()
          require("harpoon"):list():replace_at(5)
        end,
        desc = "Replace first mark",
      },
      {
        "<Tab><Tab>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Replace first mark",
      },
    },
  },
}
