local status_ok, tokyonight = pcall(require, "tokyonight.colors")
if not status_ok then
  return
end

local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
  return
end

local colors = tokyonight.setup()
return function()
  wilder.setup({ modes = { ":", "/", "?" } })

  wilder.set_option("pipeline", {
    wilder.branch(
      wilder.python_file_finder_pipeline({
        file_command = function(ctx, arg)
          if string.find(arg, ".") ~= nil then
            return { "fd", "-tf", "-H" }
          else
            return { "fd", "-tf" }
          end
        end,
        dir_command = { "fd", "-td" },
        filters = { "fuzzy_filter" },
      }),
      wilder.substitute_pipeline({
        pipeline = wilder.python_search_pipeline({
          skip_cmdtype_check = 1,
          pattern = wilder.python_fuzzy_pattern({
            start_at_boundary = 0,
          }),
        }),
      }),
      wilder.cmdline_pipeline({
        fuzzy = 2,
        fuzzy_filter = wilder.lua_fzy_filter(),
      }),
      {
        wilder.check(function(ctx, x)
          return x == ""
        end),
        wilder.history(),
      },
      wilder.python_search_pipeline({
        pattern = wilder.python_fuzzy_pattern({
          start_at_boundary = 0,
        }),
      })
    ),
  })

  local highlighters = {
    wilder.pcre2_highlighter(),
    wilder.lua_fzy_highlighter(),
  }
  local highlights = {
    default = wilder.make_hl(
      "WilderPmenu",
      "Pmenu",
      { { a = 1 }, { a = 1 }, { foreground = colors.fg, background = "#24292e" } }
    ),
    accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = colors.red, bold = 1 } }),
  }

  local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
    border = "rounded",
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = highlighters,
    highlights = highlights,
    left = {
      " ",
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = " a + ",
        icons = { ["+"] = "", a = "", h = "" },
      }),
    },
    right = {
      " ",
      wilder.popupmenu_scrollbar(),
    },
  }))

  local wildmenu_renderer = wilder.wildmenu_renderer({
    highlighter = highlighters,
    highlights = highlights,
    separator = " · ",
    left = { " ", wilder.wildmenu_spinner(), " " },
    right = { " ", wilder.wildmenu_index() },
  })

  wilder.set_option(
    "renderer",
    wilder.renderer_mux({
      [":"] = popupmenu_renderer,
      ["/"] = wildmenu_renderer,
      substitute = wildmenu_renderer,
    })
  )
end
