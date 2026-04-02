require('neo-tree').setup({
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      hide_gitignored = false,
    },
    mappings = {
      ['H'] = 'toggle_hidden',
    },
    use_libuv_file_watcher = true,
  },
  window = {
    mappings = {
      ['bc'] = 'order_by_created',
      ['bd'] = 'order_by_diagnostics',
      ['bg'] = 'order_by_git_status',
      ['bm'] = 'order_by_modified',
      ['bn'] = 'order_by_name',
      ['bs'] = 'order_by_size',
      ['bt'] = 'order_by_type',
      ['C'] = 'close_node',
      ['o'] = 'open',
      ['x'] = 'close_node',

      -- Unbind defaults with an 'o' prefix to prevent waiting on more input to
      -- disambiguate the 'o' for 'open' binding above.
      ['oc'] = 'none',
      ['od'] = 'none',
      ['og'] = 'none',
      ['om'] = 'none',
      ['on'] = 'none',
      ['os'] = 'none',
      ['ot'] = 'none',
    },
    popup = {
      size = {
        width = '80%',
      },
    },
  },
})
