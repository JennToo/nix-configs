lua << EOF
vim.opt.termguicolors = true
vim.opt.clipboard= "unnamedplus"
vim.opt.number = true
vim.opt.spelllang="en"
vim.opt.spellfile="/home/jwilcox/.config/nvim/en.utf-8.add"
vim.opt.cursorline = true

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = "*",
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end
})

-- Get indents that actually make sense
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.scrolloff = 3
vim.opt.autoread = true

local opts = { noremap=true }
vim.keymap.set('v', '<C-r>', '"hy:%s#<C-r>h##gc<left><left><left>', opts)
vim.keymap.set('i', '<C-l>', 'λ', opts)
vim.keymap.set('n', '<Leader>ff', ':Files<Cr>', opts)
vim.keymap.set('n', '<Leader>b', ':Buffers<Cr>', opts)
vim.keymap.set('n', '<Leader>st', 'mavip:w !tmux-sender REPL<Cr><Cr>`a', opts)
vim.keymap.set('v', '<Leader>ss', ':w !tmux-sender REPL<Cr><Cr>', opts)

vim.o.background = "light"
-- TODO: How to convert this?
vim.api.nvim_exec(
[[
try
    colorscheme rose-pine
catch /^Vim\%((\a\+)\)\=:E185/
    " deal with it
endtry
]], true)

-- ALE
vim.g.ale_sign_error = "!"
vim.g.ale_sign_warning = "-"
vim.g.ale_asm_gcc_executable = "arm-none-eabi-gcc"
vim.g.ale_linters = {
    cpp = {},
    python = {},
    haskell = {},
    json = {'jq'},
}
vim.api.nvim_set_hl(0, 'ALEErrorSign', { bg = 'red' })
vim.api.nvim_set_hl(0, 'ALEWarningSign', { bg = 'yellow' })

-- rst folding is annoying
vim.g.riv_disable_folding = 1
vim.g.riv_fold_level = 0
vim.g.riv_fold_auto_update = 0
vim.g.rst_syntax_folding = 0
vim.g.riv_auto_fold_force = 0
vim.opt.foldenable = false

vim.opt.wildignore = {
    '*/.ccls-cache/*',
    '*/.ezdebugger/*',
    '*.o',
    '*.d',
    '*.class',
    '*.jar',
    '*.pyc'
}

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = {'*.s', '*.S', '*.a65'},
    callback = function()
        vim.opt.filetype = 'asm_ca65'
    end
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = {'*.zuo'},
    callback = function()
        vim.opt.filetype = 'racket'
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'gitcommit', 'markdown', 'rst'},
    callback = function()
        vim.opt_local.spell = true
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'json'},
    callback = function()
        vim.opt_local.formatprg = 'jq'
    end
})

local lspconfig = require('lspconfig')
local cmp = require('cmp')

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {},
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'tmux' },
    }, {
        { name = 'vsnip' },
    })
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'hls' }
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
      capabilities = capabilities
  }
end

vim.cmd [[highlight IndentBlanklineIndent1 guibg=#E4EEEE gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#F9E9E5 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guibg=#FAF5EF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guibg=#F9E9E5 gui=nocombine]]

require("indent_blankline").setup {
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
    },
    show_trailing_blankline_indent = false,
}
EOF
