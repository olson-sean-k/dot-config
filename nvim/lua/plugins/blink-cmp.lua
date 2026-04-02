require('blink-cmp').setup({
  fuzzy = {
    implementation = 'lua',
  },
  keymap = {
    preset = 'default'
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  completion = {
    menu = {
      border = 'rounded',
    },
    documentation = {
      window = {
        border = { 'rounded' },
      },
    },
  },
})
