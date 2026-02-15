return {
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require("blame").setup({})
    end,
    keys = {
      {
        "<leader>ab",
        ":BlameToggle<CR>",
        desc = "Toggle Blame",
      },
    },
  },
}
