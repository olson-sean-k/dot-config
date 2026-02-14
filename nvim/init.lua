-- Enable legacy Pathogen bundles and add packages.
vim.cmd([[
  call pathogen#infect()
  packadd fidget
  packadd todo-comments
]])
vim.cmd.colorscheme('catppuccin-mocha')

local palette = require('catppuccin.palettes').get_palette()
vim.api.nvim_set_hl(0, '@comment.documentation', { fg = palette.pink })
vim.api.nvim_set_hl(0, '@lsp.typemod.comment.documentation', { fg = palette.pink })

require('fidget').setup({
  notification = {
    window = {
      border = 'rounded',
    },
  },
})
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

vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.backspace = {
  'eol',
  'indent',
  'start',
}
vim.opt.colorcolumn = '80'
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = {
  nbsp = '·',
  tab = '>·',
  trail = '·',
}
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.textwidth = 80
vim.opt.updatetime = 400
vim.opt.wildmenu = true
vim.opt.wildmode = {
  'list',
  'longest',
}
vim.opt.wrap = false

vim.g.ctrlp_cmd = 'CtrlPMRUFiles'
vim.g.ctrlp_working_path_mode = 1
vim.g.lightline = {
  active = {
    left = {{ 'mode', 'paste' }, { 'gitbranch', 'readonly', 'relativepath', 'modified' }},
  },
  colorscheme = 'catppuccin',
  component_function = {
    gitbranch = 'FugitiveHead',
  },
}
vim.g.mapleader = ','
vim.g.NERDTreeShowBookmarks = 1
vim.g.rustaceanvim = {
  server = {
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
        },
        inlayHints = {
          chainingHints = { enable = false },
          closingBraceHints = {
            enable = true,
            minLines = 16,
          },
          parameterHints = { enable = false },
          typeHints = { enable = false },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
  tools = {
    float_win_config = {
      border = 'rounded',
    },
  },
}

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>')
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']e', vim.diagnostic.goto_next)
vim.keymap.set({'n', 'v', 'o'}, '\\', ',', { noremap = true, silent = true })
vim.keymap.set({'n', 'v', 'o'}, '<C-h>', '<C-w>h<C-w>_', { silent = true, remap = true })
vim.keymap.set({'n', 'v', 'o'}, '<C-j>', '<C-w>j<C-w>_', { silent = true, remap = true })
vim.keymap.set({'n', 'v', 'o'}, '<C-k>', '<C-w>k<C-w>_', { silent = true, remap = true })
vim.keymap.set({'n', 'v', 'o'}, '<C-l>', '<C-w>l<C-w>_', { silent = true, remap = true })
vim.keymap.set({'n', 'v', 'o'}, '<leader>t', ':NERDTreeToggle<CR>', { silent = true })

vim.diagnostic.config({
  float = {
    border = 'rounded',
  },
  severity_sort = true,
  virtual_text = {
    prefix = '●',
  },
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NERDTreeOnlyQuit", { clear = true }),
  callback = function()
    -- When entering a buffer and it is the only remaining window and is
    -- also NERDTree, then quit Neovim.
    local tree = vim.b.NERDTree
    local has_tree = tree ~= nil
    local is_tab_tree = has_tree and tree.isTabTree ~= nil and vim.fn.eval('b:NERDTree.isTabTree()') == 1
    local is_only_window = vim.fn.winnr('$') == 1
    if is_only_window and is_tab_tree then
      vim.cmd("quit")
    end
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  -- Enable Tree-sitter for these file type patterns.
  pattern = { 'c', 'lua', 'rust' },
  callback = function()
    vim.treesitter.start()
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'toml',
  callback = function()
    local root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) or vim.fn.getcwd()
    vim.lsp.start({
      name = 'tombi',
      cmd = { 'tombi', 'lsp' },
      root_dir = root_dir,
    })
  end,
})
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local group = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = false })
      -- Highlight references when the cursor is held.
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })
      -- Clear highlighted references when the cursor is moved.
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspKeyMaps', {}),
  callback = function(event)
    -- Enable completions via `<c-x><c-o>`.
    vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    -- Set key mappings.
    local opt = { buffer = event.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opt)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opt)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opt)
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover({ border = 'rounded' })
    end, opt)
    vim.keymap.set('n', '<C-k>', function()
      vim.lsp.buf.signature_help({ border = 'rounded' })
    end, opt)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opt)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opt)
  end,
})
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspHints', {}),
  callback = function(event)
    -- Enable inlay hints.
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end
  end,
})
