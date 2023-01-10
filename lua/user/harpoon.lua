local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local h_status_ok, _ = pcall(require, "harpoon")
if not h_status_ok then
  return
end
telescope.load_extension("harpoon")

lvim.builtin.which_key.mappings["m"] = { require("harpoon.mark").add_file, "Harpoon Add" }
lvim.builtin.which_key.mappings["."] = { require("harpoon.ui").nav_next, "Harpoon Next" }
lvim.builtin.which_key.mappings[","] = { require("harpoon.ui").nav_prev, "Harpoon Prev" }
lvim.keys.normal_mode["<C-e>"] = require("harpoon.ui").toggle_quick_menu
