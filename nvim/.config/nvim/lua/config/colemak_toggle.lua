local M = {}
local current_layout = "qwerty"

-- Define all your Colemak-DHm mappings in a list of tables
-- {modes, lhs, rhs, desc}
local colemak_maps = {
  -- Movement (n, v, o)
  { { "n", "v", "o" }, "m", "h", "Navigate Left (Colemak)" },
  { { "n", "v", "o" }, "M", "H", "Go to First Non-Blank (Colemak)" },
  { { "n", "v", "o" }, "n", "j", "Navigate Down (Colemak)" },
  { { "n", "v", "o" }, "e", "k", "Navigate Up (Colemak)" },
  { { "n", "v", "o" }, "i", "l", "Navigate Right (Colemak)" },
  { { "n", "v", "o" }, "I", "L", "Go to Last Column (Colemak)" },

  -- Custom Actions (n, v)
  { { "n", "v" }, "j", "m", "Set/Toggle Bookmark (Mark)" },
  { { "n", "v", "o" }, "k", "n", "Next Search Result" },
  { { "n", "v", "o" }, "K", "N", "Previous Search Result" },
  { { "n" }, "l", "i", "Enter Insert Mode (standard)" },
  { { "n" }, "L", "I", "Enter Insert Mode (start of line)" },
  { { "n", "v", "o" }, "h", "e", "End of Word (e)" },

  -- Disable QWERTY HJKL to avoid conflicts/confusion
  -- You can optionally add these to prevent accidental use
  -- {{'n', 'v', 'o'}, 'h', '<Nop>', 'Disabled h'},
  -- {{'n', 'v', 'o'}, 'j', '<Nop>', 'Disabled j'},
  -- {{'n', 'v', 'o'}, 'k', '<Nop>', 'Disabled k'},
  -- {{'n', 'v', 'o'}, 'l', '<Nop>', 'Disabled l'},
}

-- Function to apply the Colemak-DHm mappings
local function enable_colemak()
  if current_layout == "colemak" then
    return
  end

  for _, map_def in ipairs(colemak_maps) do
    local modes, lhs, rhs, desc = unpack(map_def)
    vim.keymap.set(modes, lhs, rhs, { noremap = true, silent = true, desc = desc })
  end

  current_layout = "colemak"
  vim.notify("Colemak-DHm Keymaps ENABLED", vim.log.levels.INFO)
end

-- Function to remove the custom mappings (restoring the default QWERTY ones)
local function disable_colemak()
  if current_layout == "qwerty" then
    return
  end

  -- Delete all the custom mappings defined above (LHS)
  for _, map_def in ipairs(colemak_maps) do
    local modes, lhs = map_def[1], map_def[2]
    -- nvim_del_keymap is the Neovim API function for deleting maps
    for _, mode in ipairs(type(modes) == "table" and modes or { modes }) do
      vim.api.nvim_del_keymap(mode, lhs)
    end
  end

  current_layout = "qwerty"
  vim.notify("Colemak-DHm Keymaps DISABLED (Default QWERTY restored)", vim.log.levels.INFO)
end

-- The public toggle function
M.toggle_layout = function()
  if current_layout == "qwerty" then
    enable_colemak()
  else
    disable_colemak()
  end
end

return M
