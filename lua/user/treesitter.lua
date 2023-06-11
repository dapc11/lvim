local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" },
  },
  filetype = "gotmpl",
  used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
}

vim.treesitter.language.register("html", "xml")

lvim.builtin.treesitter.highlight = {
  enable = true,
  disable = { "gitcommit" },
  disable = function(_, bufnr)
    return vim.api.nvim_buf_line_count(bufnr) > 2000
  end,
}

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "css",
  "go",
  "gomod",
  "help",
  "java",
  "json",
  "lua",
  "python",
  "vim",
  "yaml",
}

lvim.builtin.treesitter.incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = "<CR>",
    node_incremental = "<CR>",
    scope_incremental = "<S-CR>",
    node_decremental = "<BS>",
  },
}

lvim.builtin.treesitter.textobjects = {
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
    },
  },
}
