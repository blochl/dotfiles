-- ===================
-- General Settings
-- ===================
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.history = 1000
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.wildmode = { "list:longest", "full" }
vim.opt.colorcolumn = "80"
vim.opt.laststatus = 2

-- Trailing whitespace handling
vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave" }, {
  callback = function()
    if vim.bo.buftype == "" then
      vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
    end
  end,
})
vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#ff0000" })
vim.api.nvim_create_user_command("FixWhitespace", [[%s/\s\+$//e]], {})

-- Enable true colors
vim.opt.termguicolors = true

-- Re-apply settings after plugins load (lazy.nvim is async)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.number = true
    vim.opt.cursorline = true
    vim.opt.colorcolumn = "80"
  end,
})

-- ===================
-- Colorscheme
-- ===================
vim.opt.background = "dark"

-- Solarized 256-color palette
local colors = {
  base03  = "#1c1c1c",
  base02  = "#262626",
  base01  = "#4e4e4e",
  base00  = "#585858",
  base0   = "#808080",
  base1   = "#8a8a8a",
  base2   = "#d7d7af",
  base3   = "#ffffd7",
  yellow  = "#af8700",
  orange  = "#d75f00",
  red     = "#af0000",
  magenta = "#af005f",
  violet  = "#5f5faf",
  blue    = "#0087ff",
  cyan    = "#00afaf",
  green   = "#5f8700",
}

local function apply_colorscheme()
  local c = colors
  local hl = vim.api.nvim_set_hl

  -- Basic highlighting
  hl(0, "Normal",       { fg = c.base0, bg = c.base03 })
  hl(0, "NormalNC",     { fg = c.base0, bg = c.base03 })
  hl(0, "Comment",      { fg = c.base01, italic = true })
  hl(0, "Constant",     { fg = c.cyan })
  hl(0, "String",       { fg = c.cyan })
  hl(0, "Character",    { fg = c.cyan })
  hl(0, "Number",       { fg = c.cyan })
  hl(0, "Boolean",      { fg = c.cyan })
  hl(0, "Float",        { fg = c.cyan })
  hl(0, "Identifier",   { fg = c.blue })
  hl(0, "Function",     { fg = c.blue })
  hl(0, "Statement",    { fg = c.green })
  hl(0, "Conditional",  { fg = c.green })
  hl(0, "Repeat",       { fg = c.green })
  hl(0, "Label",        { fg = c.green })
  hl(0, "Operator",     { fg = c.green })
  hl(0, "Keyword",      { fg = c.green })
  hl(0, "Exception",    { fg = c.green })
  hl(0, "PreProc",      { fg = c.orange })
  hl(0, "Include",      { fg = c.orange })
  hl(0, "Define",       { fg = c.orange })
  hl(0, "Macro",        { fg = c.orange })
  hl(0, "PreCondit",    { fg = c.orange })
  hl(0, "Type",         { fg = c.yellow })
  hl(0, "StorageClass", { fg = c.yellow })
  hl(0, "Structure",    { fg = c.yellow })
  hl(0, "Typedef",      { fg = c.yellow })
  hl(0, "Special",      { fg = c.red })
  hl(0, "SpecialChar",  { fg = c.red })
  hl(0, "Tag",          { fg = c.red })
  hl(0, "Delimiter",    { fg = c.red })
  hl(0, "SpecialComment", { fg = c.red })
  hl(0, "Debug",        { fg = c.red })
  hl(0, "Underlined",   { fg = c.violet })
  hl(0, "Ignore",       {})
  hl(0, "Error",        { fg = c.red, bold = true })
  hl(0, "Todo",         { fg = c.magenta, bold = true })

  -- Extended highlighting
  hl(0, "SpecialKey",   { fg = c.base00, bg = c.base02, bold = true })
  hl(0, "NonText",      { fg = c.base00, bold = true })
  hl(0, "StatusLine",   { fg = c.base1, bg = c.base02, reverse = true })
  hl(0, "StatusLineNC", { fg = c.base00, bg = c.base02, reverse = true })
  hl(0, "Visual",       { fg = c.base01, bg = c.base03, reverse = true })
  hl(0, "Directory",    { fg = c.blue })
  hl(0, "ErrorMsg",     { fg = c.red, reverse = true })
  hl(0, "IncSearch",    { fg = c.orange, standout = true })
  hl(0, "Search",       { fg = c.yellow, reverse = true })
  hl(0, "MoreMsg",      { fg = c.blue })
  hl(0, "ModeMsg",      { fg = c.blue })
  hl(0, "LineNr",       { fg = c.base01, bg = c.base02 })
  hl(0, "CursorLineNr", { fg = c.yellow, bg = c.base02, bold = true })
  hl(0, "Question",     { fg = c.cyan, bold = true })
  hl(0, "VertSplit",    { fg = c.base00, bg = c.base00 })
  hl(0, "Title",        { fg = c.orange, bold = true })
  hl(0, "VisualNOS",    { bg = c.base02, reverse = true })
  hl(0, "WarningMsg",   { fg = c.red, bold = true })
  hl(0, "WildMenu",     { fg = c.base2, bg = c.base02, reverse = true })
  hl(0, "Folded",       { fg = c.base0, bg = c.base02, underline = true })
  hl(0, "FoldColumn",   { fg = c.base0, bg = c.base02 })

  -- Diff highlighting
  hl(0, "DiffAdd",      { fg = c.green, bg = c.base02 })
  hl(0, "DiffChange",   { fg = c.yellow, bg = c.base02 })
  hl(0, "DiffDelete",   { fg = c.red, bg = c.base02 })
  hl(0, "DiffText",     { fg = c.blue, bg = c.base02 })

  -- UI elements
  hl(0, "SignColumn",   { fg = c.base0, bg = "NONE" })
  hl(0, "Conceal",      { fg = c.blue })
  hl(0, "SpellBad",     { undercurl = true, sp = c.red })
  hl(0, "SpellCap",     { undercurl = true, sp = c.violet })
  hl(0, "SpellRare",    { undercurl = true, sp = c.cyan })
  hl(0, "SpellLocal",   { undercurl = true, sp = c.yellow })
  hl(0, "Pmenu",        { fg = c.base0, bg = c.base02 })
  hl(0, "PmenuSel",     { fg = c.base01, bg = c.base2 })
  hl(0, "PmenuSbar",    { fg = c.base2, bg = c.base0 })
  hl(0, "PmenuThumb",   { fg = c.base0, bg = c.base03 })
  hl(0, "TabLine",      { fg = c.base0, bg = c.base02, underline = true })
  hl(0, "TabLineFill",  { fg = c.base0, bg = c.base02, underline = true })
  hl(0, "TabLineSel",   { fg = c.base01, bg = c.base2, underline = true, reverse = true })
  hl(0, "CursorColumn", { bg = c.base02 })
  hl(0, "CursorLine",   { bg = c.base02 })
  hl(0, "ColorColumn",  { bg = c.base02 })
  hl(0, "Cursor",       { fg = c.base03, bg = c.base0 })
  hl(0, "MatchParen",   { fg = c.red, bg = c.base01, bold = true })

  -- Treesitter highlighting
  hl(0, "@comment",             { link = "Comment" })
  hl(0, "@string",              { link = "String" })
  hl(0, "@number",              { link = "Number" })
  hl(0, "@boolean",             { link = "Boolean" })
  hl(0, "@function",            { link = "Function" })
  hl(0, "@function.builtin",    { fg = c.blue })
  hl(0, "@keyword",             { link = "Keyword" })
  hl(0, "@keyword.function",    { fg = c.green })
  hl(0, "@keyword.return",      { fg = c.green })
  hl(0, "@conditional",         { link = "Conditional" })
  hl(0, "@repeat",              { link = "Repeat" })
  hl(0, "@operator",            { link = "Operator" })
  hl(0, "@type",                { link = "Type" })
  hl(0, "@type.builtin",        { fg = c.yellow })
  hl(0, "@variable",            { fg = c.base0 })
  hl(0, "@variable.builtin",    { fg = c.blue })
  hl(0, "@constant",            { link = "Constant" })
  hl(0, "@constant.builtin",    { fg = c.cyan })
  hl(0, "@property",            { fg = c.base0 })
  hl(0, "@punctuation",         { fg = c.base0 })
  hl(0, "@punctuation.bracket", { fg = c.base0 })
  hl(0, "@punctuation.delimiter", { fg = c.base0 })
  hl(0, "@include",             { link = "Include" })
  hl(0, "@tag",                 { link = "Tag" })

  -- LSP highlighting
  hl(0, "DiagnosticError",      { fg = c.red })
  hl(0, "DiagnosticWarn",       { fg = c.yellow })
  hl(0, "DiagnosticInfo",       { fg = c.blue })
  hl(0, "DiagnosticHint",       { fg = c.cyan })
  hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.red })
  hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = c.yellow })
  hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = c.blue })
  hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = c.cyan })

  -- Git signs
  hl(0, "GitSignsAdd",    { fg = c.green })
  hl(0, "GitSignsChange", { fg = c.yellow })
  hl(0, "GitSignsDelete", { fg = c.red })
end

-- Apply colorscheme
apply_colorscheme()

-- Re-apply on ColorScheme event
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.defer_fn(apply_colorscheme, 0)
  end,
})

-- ===================
-- GUI Options (Neovide or other GUIs)
-- ===================
if vim.g.neovide or vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "DejaVuSansM Nerd Font Mono:h12"
end

-- ===================
-- Auto-indentation per language
-- ===================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dockerfile",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
