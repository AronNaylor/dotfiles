-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- inc-rename
map("n", "<leader>ir", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- Enable Copilot
map("n", "<leader>ae", ":Copilot enable<CR>", { desc = "Enable Copilot", unpack(opts) })

-- Disable Copilot
map("n", "<leader>ad", ":Copilot disable<CR>", { desc = "Disable Copilot", unpack(opts) })

-- Show Copilot status
map("n", "<leader>as", ":Copilot status<CR>", { desc = "Show Copilot status", unpack(opts) })

-- Open Copilot Chat model selection
map("n", "<leader>ac", ":Copilot chat model<CR>", { desc = "Open Copilot Chat model selection", unpack(opts) })
