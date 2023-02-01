local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
local ts = lvim.builtin.treesitter
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" },
  },
  filetype = "gotmpl",
  used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml", "tpl", "yml" },
}
ts.highlight.enable = true
ts.ensure_installed = {
  "vim",
  "bash",
  "json",
  "help",
  "lua",
  "go",
  "gomod",
  "python",
  "css",
  "java",
  "yaml",
}
ts.incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = "<CR>",
    node_incremental = "<CR>",
    scope_incremental = "<S-CR>",
    node_decremental = "<BS>",
  },
}

ts.textobjects = {
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      ["<m"] = "@function.outer",
      ["<<"] = "@class.outer",
    },
    goto_next_end = {
      ["<M"] = "@function.outer",
      ["<>"] = "@class.outer",
    },
    goto_previous_start = {
      [">m"] = "@function.outer",
      [">>"] = "@class.outer",
    },
    goto_previous_end = {
      [">M"] = "@function.outer",
      ["><"] = "@class.outer",
    },
  },
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["if"] = "@function.inner",
      ["aC"] = "@class.outer",
      ["iC"] = "@class.inner",
      ["ac"] = "@conditional.outer",
      ["ic"] = "@conditional.inner",
      ["ae"] = "@block.outer",
      ["ie"] = "@block.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["is"] = "@statement.inner",
      ["as"] = "@statement.outer",
      ["ad"] = "@comment.outer",
      ["am"] = "@call.outer",
      ["im"] = "@call.inner",
      ["iF"] = {
        python = "(function_definition) @function",
        cpp = "(function_definition) @function",
        c = "(function_definition) @function",
        java = "(method_declaration) @function",
        go = "(method_declaration) @function",
      },
    },
  },
}
