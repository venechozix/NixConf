-- Import telescope safely
local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  vim.notify("Telescope not found!", vim.log.levels.ERROR)
  return
end

-- Setup Telescope (optional defaults)
telescope.setup({
  defaults = {
    layout_strategy = "flex",
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
  },
})

-- Keymaps for Telescope
local builtin = require("telescope.builtin")

-- Normal mode keybinds
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
