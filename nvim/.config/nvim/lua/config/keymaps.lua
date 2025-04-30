-- Lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.cmd([[cab cc CodeCompanion]])

-- Copilot keymaps
map("n", "<leader>ae", ":Copilot enable<CR>", { desc = "Enable Copilot", unpack(opts) })
map("n", "<leader>ad", ":Copilot disable<CR>", { desc = "Disable Copilot", unpack(opts) })
map("n", "<leader>as", ":Copilot status<CR>", { desc = "Show Copilot status", unpack(opts) })

-- CodeCompanion keymaps under <leader>k, we may want to alter this at a later date
map("n", "<leader>ai", ":CodeCompanion<CR>", { desc = "CodeCompanion Inline Assistant", unpack(opts) })
map("n", "<leader>ac", ":CodeCompanionChat<CR>", { desc = "CodeCompanion Chat Buffer", unpack(opts) })
map("n", "<leader>am", ":CodeCompanionCmd<CR>", { desc = "CodeCompanion Generate commandline", unpack(opts) })
map("n", "<leader>aa", ":CodeCompanionActions<CR>", { desc = "CodeCompanion Command Palette", unpack(opts) })
map({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Command Palette", unpack(opts) })
map(
  { "n", "v" },
  "<LocalLeader>a",
  "<cmd>CodeCompanionChat Toggle<cr>",
  { desc = "Toggle CodeCompanion Chat", unpack(opts) }
)
map(
  "v",
  "<leader>aa",
  "<cmd>CodeCompanionChat Add<cr>",
  { desc = "Add selected text to CodeCompanion Chat", unpack(opts) }
)
