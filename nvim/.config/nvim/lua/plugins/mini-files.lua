-- if true then
--   return {}
-- end

return {
  "nvim-mini/mini.files",
  config = function()
    require("mini.files").setup({
      windows = {
        preview = true,
        width_focus = 30,
        width_nofocus = 15,
        width_preview = 50,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
      mappings = {
        go_out_plus = "<Left>",
        go_in_plus = "<Right>",
      },
    })
  end,
}
