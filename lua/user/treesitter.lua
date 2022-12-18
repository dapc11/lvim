lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ensure_installed = {
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

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" },
  },
  filetype = "gotmpl",
  used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml", "tpl", "yml" },
}

lvim.builtin.treesitter.textobjects.enable = true
lvim.builtin.treesitter.textobjects.keymaps = {
  ["iL"] = {
    -- you can define your own textobjects directly here
    go = "(function_definition) @function",
  },
  -- or you use the queries from supported languages with textobjects.scm
  ["af"] = "@function.outer",
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
}

lvim.builtin.treesitter.textobjects.move = {
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
}
lvim.builtin.treesitter.textobjects.select = {
  enable = true,
  keymaps = {
    -- You can use the capture groups defined in textobjects.scm
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ac"] = "@class.outer",
    ["ic"] = "@class.inner",
    -- Or you can define your own textobjects like this
    ["iF"] = {
      python = "(function_definition) @function",
      cpp = "(function_definition) @function",
      c = "(function_definition) @function",
      java = "(method_declaration) @function",
      go = "(method_declaration) @function",
    },
  },
}
