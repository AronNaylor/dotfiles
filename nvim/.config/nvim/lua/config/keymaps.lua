-- Lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Copilot keymaps
map("n", "<leader>ae", ":Copilot enable<CR>", { desc = "Enable Copilot", unpack(opts) })
map("n", "<leader>ad", ":Copilot disable<CR>", { desc = "Disable Copilot", unpack(opts) })
map("n", "<leader>as", ":Copilot status<CR>", { desc = "Show Copilot status", unpack(opts) })
map("n", "<leader>ac", ":CopilotChatModel<CR>", { desc = "Open Copilot Chat model selection", unpack(opts) })

-- CodeCompanion keymaps under <leader>k, we may want to alter this at a later date
map("n", "<leader>akk", ":CodeCompanion<CR>", { desc = "CodeCompanion Inline Assistant", unpack(opts) })
map("n", "<leader>akc", ":CodeCompanionChat<CR>", { desc = "CodeCompanion Chat Buffer", unpack(opts) })
map("n", "<leader>akm", ":CodeCompanionCmd<CR>", { desc = "CodeCompanion Generate commandline", unpack(opts) })
map("n", "<leader>aka", ":CodeCompanionActions<CR>", { desc = "CodeCompanion Command Palette", unpack(opts) })
