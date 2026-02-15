-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Custom shortcut for Biome Check & Fix
vim.keymap.set("n", "<leader>af", function()
  local biome = LazyVim.root() .. "/node_modules/.bin/biome"
  if vim.fn.filereadable(biome) == 0 then
    vim.notify("Biome is not installed in this project", vim.log.levels.WARN)
    return
  end
  vim.cmd("silent write")
  local output = vim.fn.system({ biome, "check", "--write", vim.api.nvim_buf_get_name(0) })
  if vim.v.shell_error ~= 0 then
    vim.notify("Biome check failed:\n" .. output, vim.log.levels.ERROR)
  end
  vim.cmd("edit")
end, { desc = "Biome Check & Fix" })

-- Toggle code companion
vim.keymap.set("n", "<leader>ac", function()
  require("codecompanion").toggle()
end, { desc = "CodeCompanion: Chat Toggle" })

-- GitUI (replaces lazygit)
vim.keymap.set("n", "<leader>gg", function()
  Snacks.terminal("gitui", { cwd = LazyVim.root() })
end, { desc = "GitUI (Root Dir)" })
vim.keymap.set("n", "<leader>gG", function()
  Snacks.terminal("gitui")
end, { desc = "GitUI (cwd)" })

-- Swap ' and " so single quote accesses registers, double quote jumps to marks
vim.keymap.set({ "n", "v" }, "'", '"', { noremap = true })
vim.keymap.set({ "n", "v" }, '"', "'", { noremap = true })

-- Arrow key window navigation
vim.keymap.set("n", "<C-w><Up>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-w><Down>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-w><Left>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-w><Right>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader><space>", LazyVim.pick("files", { root = false }), { desc = "Find Files (cwd)" })

--Require the new module
local colemak = require("config.colemak_toggle")

-- Add your new toggle shortcut
vim.keymap.set("n", "<leader>at", colemak.toggle_layout, { desc = "Toggle Colemak-DHm Layout On/Off" })

-- You can also optionally start in Colemak mode by calling the function here:
-- colemak.toggle_layout()
