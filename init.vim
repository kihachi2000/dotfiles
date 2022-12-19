if has('unix')
    let g:python3_host_prog = '/usr/bin/python3'
    let s:nvim_cache = $HOME . '/.cache'
    let s:dotfiles = $HOME . '/.dotfiles'
endif

if has('win64')
    let g:python3_host_prog = $HOME . '\AppData\Local\Programs\Python\Python39\python.exe'
    let s:nvim_cache = $HOME . '/.cache/nvim'
    let s:dotfiles = $HOME . '\git\.dotfiles'
endif

"----------------------------------------------------------------------
" dein.vim
"----------------------------------------------------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
if has('unix')
    set runtimepath+=$HOME/.config/nvim/.cache/dein/repos/github.com/Shougo/dein.vim
endif

if has('win64')
    set runtimepath+=$HOME/.cache/nvim/dein/repos/github.com/Shougo/dein.vim
endif

" Required:
call dein#begin(s:nvim_cache . '/dein')

" Let dein manage dein
" Required:
call dein#add(s:nvim_cache . '/dein/repos/github.com/Shougo/dein.vim')

" zenbonesの依存プラグイン
call dein#add('rktjmp/lush.nvim')

" カラースキーム
call dein#add('cocopon/iceberg.vim')
call dein#add('mcchrish/zenbones.nvim')
call dein#add('shaunsingh/seoul256.nvim')
"call dein#add('drewtempelmeyer/palenight.vim')
"call dein#add('hrsh7th/palenight.vim')
call dein#add('sainnhe/everforest')
call dein#add('rebelot/kanagawa.nvim')
call dein#add('folke/tokyonight.nvim')
call dein#add('itchyny/lightline.vim')
call dein#add('kyazdani42/blue-moon')

" 見た目系
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('nvim-treesitter/nvim-treesitter', {'merged': 0})
call dein#add('nvim-treesitter/playground')

" ファイラー
call dein#add('Shougo/defx.nvim')

" 編集ツール
call dein#add('mhinz/vim-sayonara')   "バッファツール
call dein#add('cohama/lexima.vim')
call dein#add('tpope/vim-surround')
call dein#add('unblevable/quick-scope')
call dein#add('phaazon/hop.nvim', {'branch': 'v2'})

" LSP系
call dein#add('williamboman/mason.nvim')
call dein#add('williamboman/mason-lspconfig.nvim')
call dein#add('neovim/nvim-lspconfig')
call dein#add('hrsh7th/vim-vsnip')
call dein#add('hrsh7th/vim-vsnip-integ')
call dein#add('folke/lsp-colors.nvim')
call dein#add('hrsh7th/nvim-cmp')
call dein#add('hrsh7th/cmp-nvim-lsp')
call dein#add('hrsh7th/cmp-buffer')
call dein#add('hrsh7th/cmp-path')
call dein#add('hrsh7th/cmp-cmdline')
call dein#add('hrsh7th/cmp-vsnip')

" 便利ツール
call dein#add('nvim-lua/plenary.nvim')
call dein#add('nvim-telescope/telescope.nvim', {'tag': '0.1.0'})
call dein#add('tpope/vim-fugitive')

" 自作
call dein#add('Kenbayashi/retrieve.nvim')
call dein#add('Kenbayashi/yash.nvim')


" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif


"----------------------------------------------------------------------
" lightline.vim
"----------------------------------------------------------------------
" ステータスラインを下から２行目に常時表示
set laststatus=2

" カラースキームを設定
"let g:lightline = {'colorscheme' : 'iceberg'}
"let g:lightline = {'colorscheme' : 'palenight'}
let g:lightline = {'colorscheme': 'blue-moon'}
"let g:lightline = {'colorscheme': 'kanagawa'}
"let g:lightline = {'colorscheme': 'tokyonight'}


"----------------------------------------------------------------------
" vim-indent-guides
"----------------------------------------------------------------------
" インデントガイドを有効化
let g:indent_guides_enable_on_vim_startup=1

" 自動カラーを無効化する
let g:indent_guides_auto_colors=0

" 奇数インデントの色
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#242940 ctermbg=236 
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#11162c

" 偶数インデントの色
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#32364c ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#181f3e

" 無効にするファイルタイプを指定する
let g:indent_guides_exclude_filetypes = ['defx']


"----------------------------------------------------------------------
" nvim-treesitter
"----------------------------------------------------------------------
lua << EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {
        }
    },
    indent = {
        enable = true,
    }
}
EOF


"----------------------------------------------------------------------
" LSP
"----------------------------------------------------------------------
" ログレベル
"vim.lsp.set_log_level("debug")

" リーダーキーの割り当て
let mapleader = ';'

" 各種機能の割り当て
nnoremap <silent> <Leader>i :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>d :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>D :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>m :lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <Leader>e :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

lua << EOF
    require("mason").setup()
    require("mason-lspconfig").setup()

    local nvim_lsp = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    mason_lspconfig.setup_handlers({
        function(server_name)
            local opts = {}

            if server_name == "jdtls" then
                opts.capabilities = capabilities
                opts.cmd = {
                   "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xms1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-jar", "C:\\Java\\jdt-language-server-1.14.0\\plugins\\org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
                    "-configuration", "C:\\Java\\jdt-language-server-1.14.0\\config_win",
                    "-data", vim.loop.os_homedir() .. "\\workspace"
                }
            end

            if server_name == "sumneko_lua" then
                opts.settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"},
                        },
                    },
                }
            end

            nvim_lsp[server_name].setup(opts)
        end
    })

    nvim_lsp.rust_analyzer.setup{capabilities = capabilities}
    nvim_lsp.gopls.setup{capabilities = capabilities}
    nvim_lsp.clangd.setup{capabilities = capabilities}
    nvim_lsp.html.setup{capabilities = capabilities}
    nvim_lsp.cssls.setup{capabilities = capabilities}
    nvim_lsp.tsserver.setup{capabilities = capabilities}
    nvim_lsp.jsonls.setup{capabilities = capabilities}

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            underline = true,
            signs = true,
        }
    )
EOF

" 自動でポップを表示する設定
set updatetime=200
autocmd CursorHold * lua vim.diagnostic.open_float(0, {scope="line", focus=false})

sign define DiagnosticSignError text= texthl= linehl=DiagnosticLineError numhl=DiagnosticLineNrError
sign define DiagnosticSignWarn text= texthl= linehl=DiagnosticLineWarn numhl=DiagnosticLineNrWarn
sign define DiagnosticSignHint text= texthl= linehl=DiagnosticLineHint numhl=DiagnosticLineNrHint
sign define DiagnosticSignInfo text= texthl= linehl=DiagnosticLineInfo numhl=DiagnosticLineNrInfo


"----------------------------------------------------------------------
" nvim-cmp
"----------------------------------------------------------------------
set completeopt=menuone,noselect

lua << EOF
    -- Setup nvim-cmp.
    local cmp = require'cmp'

    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-y>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'vsnip' }, -- For vsnip users.
            { name = 'nvim_lsp' },
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
      sources = {
          { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
EOF


"----------------------------------------------------------------------
" hop.nvim
"----------------------------------------------------------------------
lua << EOF
require('hop').setup({ keys = 'jwhdnkrtlsypuif.e,oaq;' })

vim.api.nvim_set_keymap('n', 'w', "<cmd>HopWordCurrentLine<CR>", {noremap = true})
vim.api.nvim_set_keymap('v', 'w', "<cmd>HopWordCurrentLine<CR>", {noremap = true})
EOF


"----------------------------------------------------------------------
" vim-vsnip
"----------------------------------------------------------------------
imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

let g:vsnip_filetypes = {}
let g:vsnip_filetypes.typescriptreact = ['typescript']


"----------------------------------------------------------------------
" defx.nvim
"----------------------------------------------------------------------
nnoremap <silent> <TAB> :Defx<CR>

autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
    nnoremap<silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open') :
                \ defx#do_action('multi', [['drop','vsplit'],'quit'])
    nnoremap<silent><buffer><expr> <S-CR>
                \ defx#do_action('multi', [['drop','split'],'quit'])
    nnoremap<silent><buffer><expr> h
                \ line('.') == 1 ?
                \ defx#do_action('cd', ['..']) :
                \ defx#do_action('close_tree')
    nnoremap<silent><buffer><expr> l
                \ defx#is_directory() ?
                \ defx#is_opened_tree() ?
                \ 'j' :
                \ defx#do_action('open_tree') :
                \ defx#do_action('multi', ['drop','quit'])
    nnoremap<silent><buffer><expr> to
                \ defx#do_action('new_file')
    nnoremap<silent><buffer><expr> mk
                \ defx#do_action('new_directory')
    nnoremap<silent><buffer><expr> mv
                \ defx#do_action('rename')
    nnoremap<silent><buffer><expr> y
                \ defx#do_action('copy')
    nnoremap<silent><buffer><expr> p
                \ defx#do_action('paste')
    nnoremap<silent><buffer><expr> rm
                \ defx#do_action('remove')
    nnoremap<silent><buffer><expr> Y
                \ defx#do_action('yank_path')
    nnoremap<silent><buffer><expr> n
                \ defx#do_action('toggle_select') . 'j'
    nnoremap<silent><buffer><expr> *
                \ defx#do_action('toggle_select_all')
    nnoremap<silent><buffer><expr> .
                \ defx#do_action('toggle_ignored_files')
    nnoremap<silent><buffer><expr> r
                \ defx#do_action('redraw')
    nnoremap<silent><buffer><expr> cd
                \ defx#do_action('cd',[])
    nnoremap<silent><buffer><expr> rc
                \ defx#do_action('cd',[expand(s:dotfiles)])
    nnoremap<silent><buffer><expr> doc
                \ defx#do_action('cd',[$HOME . '\Documents'])
    nnoremap<silent><buffer><expr> git
                \ defx#do_action('cd',[$HOME . '\git'])
    nnoremap<silent><buffer><expr> q
                \ defx#do_action('quit')
endfunction

call defx#custom#option('_', {
            \ 'winwidth': 40,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'buffer_name': 'Filer',
            \ 'toggle': 1,
            \ 'resume': 1,
            \ })


"----------------------------------------------------------------------
" lexima
"----------------------------------------------------------------------
" デフォルトルールを有効化
let g:lexima_enable_basic_rules = 1

" インデントするルールのやつ
let g:lexima_enable_newline_rules = 1

"tagのインデント
call lexima#add_rule({'char': '<CR>', 'at': '>\%#</', 'input_after': '<CR>'})

" C-jで囲みから抜けるやつ
call lexima#add_rule({'char': '<C-j>', 'at': '\%#)', 'input': '<Right>'})
call lexima#add_rule({'char': '<C-j>', 'at': '\%#]', 'input': '<Right>'})
call lexima#add_rule({'char': '<C-j>', 'at': '\%#}', 'input': '<Right>'})
call lexima#add_rule({'char': '<C-j>', 'at': '\%#>', 'input': '<Right>'})
call lexima#add_rule({'char': '<C-j>', 'at': '\%#''', 'input': '<Right>'})
call lexima#add_rule({'char': '<C-j>', 'at': '\%#"', 'input': '<Right>'})
call lexima#add_rule({'char': '<C-j>', 'at': '\%#`', 'input': '<Right>'})

" C-jでセミコロンを飛ばすやつ
call lexima#add_rule({'char': '<C-j>', 'at': '\%#;', 'input': '<Right>'})


"----------------------------------------------------------------------
" vim-surround
"----------------------------------------------------------------------
" デフォルトルールを使用しない
let g:surround_no_mappings = 1

nnoremap s <nop>

" 各種キー設定
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap s <Plug>Ysurround
xmap s <Plug>VSurround

nmap dss <Plug>Dsurround/ <Plug>Dsurround*
nmap ss <Plug>Yssurround* <Plug>Yssurround/


"----------------------------------------------------------------------
" quick-scope
"----------------------------------------------------------------------
" 反応するキー
let g:qs_highlight_on_keys = ['f', 'F']

" 見た目


"----------------------------------------------------------------------
" telescope.nvim
"----------------------------------------------------------------------
lua << EOF
local theme = require("telescope.themes").get_dropdown({
    previewer = false,
    prompt_prefix = "Find: ",
    prompt_title = '',
    results_title = '',
    borderchars = {
        prompt = {' ', ' ', ' ', ' ', '+', '+', ' ', ' '},
        results = {' ', ' ', ' ', ' ', ' ', ' ', '+', '+'},
        preview = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    },
})

local builtin = require("telescope.builtin")
local function find_files()
    theme.prompt_prefix = "File: "
    return builtin.find_files(theme)
end

local function live_grep()
    theme.prompt_prefix = "Grep: "
    return builtin.live_grep(theme)
end

local function buffers()
    theme.prompt_prefix = "Buffer: "
    return builtin.buffers(theme)
end

vim.keymap.set("n", "<C-p>", find_files, {noremap = false})
vim.keymap.set("n", "<C-g>", live_grep, {noremap = false})
vim.keymap.set("n", "<C-b>", buffers, {noremap = false})
EOF


"----------------------------------------------------------------------
" fugitive.vim
"----------------------------------------------------------------------
" git add
nnoremap ga <cmd>Git add .<CR><CR>

" git commit
nnoremap gc <cmd>Git commit<CR><CR>



"----------------------------------------------------------------------
" retrieve.nvim
"----------------------------------------------------------------------
" 開発用
"set runtimepath^=$HOME\git\retrieve

lua << EOF
require("retrieve").setup()
vim.keymap.set("n", "m", "<Plug>retrieve-set", {noremap = false})
vim.keymap.set("n", "M", "<Plug>retrieve-return", {noremap = false})
EOF


"----------------------------------------------------------------------
" yash.nvim
"----------------------------------------------------------------------
" 開発用
set runtimepath^=$HOME\git\yash

"----------------------------------------------------------------------
" 設定
"----------------------------------------------------------------------
" カレントディレクトリをホームに移動
"cd $HOME

" 文字コードをUTF-8に設定
set fenc=utf-8

" バックアップファイルを作成しない
set nobackup
set nowritebackup

" スワップファイルを作成しない
set noswapfile

" バッファが編集中でも切り替えられるようにする
set hidden

" クリップボード周りのもろもろ
set clipboard&
set clipboard^=unnamedplus

" タブ文字を半角スペースに設定する
set expandtab

" タブ文字を半角４文字分にする
set tabstop=4
set shiftwidth=4

" 2行早くスクロールする
set scrolloff=2

" 対応する括弧を表示
set showmatch matchtime=1

" スマートインデント
set smartindent 

" キーコンフィグ
" xmapはビジュアルのみに適用できる
nnoremap j gj
nnoremap k gk
nnoremap H ^
nnoremap L $

xnoremap j gj
xnoremap k gk
xnoremap H ^
xnoremap L $

nnoremap < <h
nnoremap > >l
nnoremap p p`]
nnoremap yy yy`]
nnoremap K 3<C-y>
nnoremap J 3<C-e>

nnoremap <silent> <leader>bb <cmd>b#<CR>
nnoremap <silent> <leader>bd <cmd>Sayonara<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-,> <C-w><
nnoremap <C-.> <C-w>>
nnoremap <C-=> <C-w>=

nnoremap <silent> <Leader>w <cmd>w<CR>
nnoremap <silent> <Leader>q <cmd>wq<CR>

nnoremap <F23> <nop>
inoremap <F23> <nop>
vnoremap <F23> <nop>

inoremap <ESC> <ESC><ESC>

nnoremap <silent> ? :noh<CR>

vnoremap y y`]

nnoremap <Leader>s <cmd>TSHighlightCapturesUnderCursor<CR>

nnoremap <Leader>r <cmd>source $HOME\AppData\Local\nvim\init.vim<CR>


"----------------------------------------------------------------------
" 検索
"----------------------------------------------------------------------
" 検索時に大文字小文字を区別しない
set ignorecase

" ignorecaseの拡張設定
set smartcase

" 検索がファイル末尾まで進んだら先頭に戻る
set wrapscan

" 検索ワード１文字目入力時点で検索を開始
set incsearch

" 検索結果をハイライト
set hlsearch


"----------------------------------------------------------------------
" 表示設定
"----------------------------------------------------------------------
" タイトルにファイル名を表示
"set title

set ambiwidth=double

" true color
if (has("nvim") && has("termguicolors"))
    set termguicolors
endif

" カラーシンタックス
syntax on
colorscheme yash
"colorscheme OceanicNext
"colorscheme kanagawa
"colorscheme everforest
"colorscheme monokuro
"colorscheme blue-moon
"colorscheme paleknight
"colorscheme iceberg
"colorscheme palenight

"colorscheme zenburned
"colorscheme tokyobones
"colorscheme seoulbones
"colorscheme seoul256

" カラースキームの上書き
if (g:colors_name == 'seoulbones')
    "hi! Comment gui=NONE
    hi! TSRepeat guifg=#97bdde
endif

" 背景色を変更
"highlight Normal guibg=#0a0d1a

" EOF以降の背景色をNormalに統一する
"highlight LineNr guibg=none ctermbg=none
"highlight SignColumn guibg=none ctermbg=none
"highlight EndOfBuffer guibg=none ctermbg=none

" マルチウインドウの縦線を隠す
"highlight VertSplit guibg=#0a0d1a guifg=#0a0d1a

" -- 挿入 --を表示しない
set noshowmode

" 行番号を表示
set number

" サインコラムを非表示
set signcolumn=no

" カーソルラインを有効化
set cursorline

" カーソルラインの色を透明にする
highlight clear CursorLine

" カーソルラインの行番号の強調設定
highlight CursorLineNr term=bold cterm=NONE ctermfg=228 ctermbg=NONE

" quick-scope
highlight QuickScopePrimary guifg='#88ff88' gui=underline
highlight QuickScopeSecondary guifg='#88ff88' gui=underline

" Telescope
highlight TelescopeBorder guibg=#181f3e 
highlight TelescopeMatching guifg=#9abdea 
highlight TelescopePromptNormal guibg=#181f3e 
highlight TelescopePromptPrefix guifg=#f4af24
highlight TelescopeResultsNormal guibg=#181f3e guifg=#d0d0d0
highlight TelescopeSelection guibg=#4054a5 

" カーソルの形
let &t_SI .= "\e[6 q"
let &t_SR .= "\e[2 q"
let &t_EI .= "\e[2 q"

" マウス有効化
set mouse=a
