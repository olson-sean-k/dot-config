return function(palette)
  require('hlchunk').setup({
    chunk = {
      enable = true,
      delay = 100,
      style = {
        palette.peach,
        palette.red,
      },
      use_treesitter = true,
    },
    indent = {
      enable = true,
      chars = { '┆' },
      use_treesitter = true,
    },
  })
end
