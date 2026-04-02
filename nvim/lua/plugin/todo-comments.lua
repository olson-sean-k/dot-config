require('todo-comments').setup({
  highlight = {
    after = '',
    keyword = 'fg',
  },
  keywords = {
    BUG = {
      color = 'error',
      alt = {
        'FIX',
        'FIXME',
        'ISSUE',
      },
    },
    LINT = { color = 'info' },
    SAFETY = { color = 'warning' },
    TODO = { color = 'info' },
    WARNING = {
      color = 'warning',
      alt = {
        'WARN',
      },
    },
  },
  merge_keywords = false,
})
