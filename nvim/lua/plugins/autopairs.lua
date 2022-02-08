require('nvim-autopairs').setup{
  check_ts = true,
  disable_filetype = { "TelescopePrompt" , "guihua", "guihua_rust", "clap_input" },
  ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
}
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

npairs.add_rules {
  Rule("$", "$",{"tex", "latex"})
    -- don't add a pair if the next character is %
    :with_pair(cond.not_after_regex_check("%%"))
    -- don't add a pair if  the previous character is $
    :with_pair(cond.not_before_regex_check("%$"))
    -- disable add newline when press <cr>
    :with_cr(cond.none()),
  Rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col -1, opts.col)
      return vim.tbl_contains({ '()', '{}', '[]' }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({ '(  )', '{  }', '[  ]' }, context)
    end),
  Rule('', ' )')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ')' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(')'),
  Rule('', ' }')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == '}' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key('}'),
  Rule('', ' ]')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ']' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(']'),
  require'nvim-autopairs'.get_rule('(')
    :with_pair(cond.not_before_regex_check("lr", 2)),
  require'nvim-autopairs'.get_rule('[')
    :with_pair(cond.not_before_regex_check("lr", 2)),
  require'nvim-autopairs'.get_rule('{')
    :with_pair(cond.not_before_regex_check("lr", 2)),
}
