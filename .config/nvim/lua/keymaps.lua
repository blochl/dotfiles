-- ===================
-- Keymaps
-- ===================
local map = vim.keymap.set

-- ===================
-- Spelling
-- ===================
map("n", "<leader>s", "<cmd>set spelllang=en_us spell!<CR>", { silent = true, desc = "Toggle spell check" })

-- ===================
-- Buffer navigation
-- ===================
map("n", "<F12>", "<cmd>bn!<CR>", { silent = true, desc = "Next buffer" })
map("n", "<F11>", "<cmd>bp!<CR>", { silent = true, desc = "Previous buffer" })
map("n", "<F5>", ":buffers<CR>:buffer ", { desc = "List buffers and pick" })

-- ===================
-- nvim-tree
-- ===================
map("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "Toggle file tree" })

-- ===================
-- Symbols outline (LSP-based)
-- ===================
map("n", "<leader>b", "<cmd>Outline<CR>", { silent = true, desc = "Toggle symbols outline" })

-- ===================
-- Man pages (Neovim built-in)
-- ===================
map("n", "K", function()
  vim.cmd("Man " .. vim.fn.expand("<cword>"))
end, { silent = true, desc = "Open man page for word under cursor" })

-- ===================
-- Header/source switching
-- ===================
map("n", "<leader>a", function()
  local alt_extensions = {
    h = { "c", "cpp", "cc", "cxx" },
    hpp = { "cpp", "cc", "cxx" },
    c = { "h" },
    cpp = { "hpp", "h" },
    cc = { "hpp", "h" },
    cxx = { "hpp", "h" },
  }
  local ext = vim.fn.expand("%:e")
  local base = vim.fn.expand("%:r")
  for _, alt in ipairs(alt_extensions[ext] or {}) do
    local alt_file = base .. "." .. alt
    if vim.fn.filereadable(alt_file) == 1 then
      vim.cmd("edit " .. alt_file)
      return
    end
  end
  print("No alternate file found")
end, { silent = true, desc = "Switch header/source" })

-- ===================
-- Telescope search
-- ===================
map("n", "<leader>f", function()
  require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end, { silent = true, desc = "Search word under cursor" })

map("n", "<space>/", "<cmd>Telescope live_grep<CR>", { silent = true, desc = "Live grep" })

map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { silent = true, desc = "Find files" })

-- ===================
-- Easy Align
-- ===================
map("v", "<Enter>", ":EasyAlign<CR>", { silent = true, desc = "Easy align" })
