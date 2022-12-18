local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
  return
end

neoscroll.setup({
  -- All these keys will be mapped to their corresponding default scrolling animation
  mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
  hide_cursor = true, -- Hide cursor while scrolling
  stop_eof = true, -- Stop at <EOF> when scrolling downwards
  use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
  respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
  -- easing_function = nil, -- Default easing function
  -- pre_hook = nil, -- Function to run before the scrolling animation starts
  -- post_hook = nil, -- Function to run after the scrolling animation ends
})

local mappings = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- mappings['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
-- mappings['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '250'}}
-- mappings['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}}
-- mappings['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450'}}
-- mappings['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
-- mappings['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
-- mappings['H'] = {'scroll', {'-0.10', 'true', '100'}}
-- mappings['L'] = {'scroll', { '0.10', 'true', '100'}}
mappings["<c-k>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
mappings["<c-j>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
-- mappings['zt']    = {'zt', {'250'}}
-- mappings['zz']    = {'zz', {'250'}}
-- mappings['zb']    = {'zb', {'250'}}

require("neoscroll.config").set_mappings(mappings)
