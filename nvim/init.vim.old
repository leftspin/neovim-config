" This vimrc attempts to be nvim/vim agnostic, but it's a better experience in nvim.

" git-plug plugin manager ______________________________________________________
if has('nvim')
    call plug#begin(stdpath('data') . '/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'} 
else
	" because plain old vim doesn't change the cursor shape for us in insert mode
	let &t_SI.="\e[5 q"  " SI = INSERT mode
	let &t_SR.="\e[4 q"  " SR = REPLACE mode
	let &t_EI.="\e[1 q"  " EI = NORMAL mode
    call plug#begin('~/.vim/plugged')
endif

" All plugins combined here
Plug 'jparise/vim-graphql'
Plug 'github/copilot.vim'
Plug 'APZelos/blamer.nvim'
Plug 'vim-scripts/lightline'
Plug 'mhinz/vim-startify'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'justinmk/vim-sneak'
Plug 'mattn/emmet-vim'
Plug 'hallzy/lightline-onedark'
Plug 'alvan/vim-closetag'
Plug 'airblade/vim-gitgutter'
Plug 'jamestthompson3/nvim-remote-containers'
Plug 'vim-test/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'karb94/neoscroll.nvim'
Plug 'Yggdroot/indentLine'

" Dependencies for certain plugins
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

call plug#end()

" Avante Setup _________________________________________________________________
lua << EOF
function SetupAvante()
  require('render-markdown').setup({    
    file_types = { "markdown", "Avante" },
  })
  require("avante").setup({
    provider = "openai",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "o3-mini",
      temperature = 0,
      max_tokens = 4096,
      reasoning_effort = "high",
    },
    windows = {
      sidebar_header = {
        enabled = true,
        align = "center",
        rounded = true,
      },
      ask = {
        floating = false,
        start_insert = true,
        border = "rounded",
        focus_on_apply = "ours",
      },
    },
    mappings = {
      ask = ";a",
      edit = ";e",
      refresh = ";r"
    },
  })
end
EOF

autocmd VimEnter * lua SetupAvante()

" Theme stuff __________________________________________________________________
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
colorscheme clarity
highlight CocCodeLens guifg=#505050 
set guicursor=n-v-c:block-Cursor/lCursor-blinkon5000-blinkoff50-blinkwait100,i-ci-cr:Cursor-ver20-blinkon2000-blinkoff50-blinkwait100

" Settings _____________________________________________________________________
set laststatus=2       " needed for lightline
set shell=zsh\ -i
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set noshowmode
set wrap
set linebreak
set list listchars=tab:»·,trail:·
set ls=2
set noequalalways
set shell=/bin/bash

" Config _______________________________________________________________________
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" TypeScript typecheck
let g:issues = []
let g:typecheck_run = 0

function! RemoveAnsiEscapeCodes(string)
  return substitute(a:string, '\e\[[0-9;]*m', '', 'g')
endfunction

function! HandleOutput(job_id, data, event)
  if a:event == 'stdout' || a:event == 'stderr'
    for l:line in a:data
      let l:clean_line = RemoveAnsiEscapeCodes(l:line)
      let l:match = matchlist(l:clean_line, '\v^(.*):(\d+):(\d+)\s+-\s+error\s+(\w+):\s+(.*)$')
      if !empty(l:match)
        let g:issues = add(g:issues, {
              \ 'filename': l:match[1],
              \ 'lnum': l:match[2],
              \ 'col': l:match[3],
              \ 'text': l:match[4] . ': ' . l:match[5],
              \ 'type': 'E'
              \ })
      endif
    endfor
  elseif a:event == 'exit'
    call setqflist(g:issues)
    let g:issues = []
    let g:typecheck_run = 0
    echom 'Typecheck complete'
  endif
endfunction

function! TypeCheck(open_quickfix=0, async=0)
  if g:typecheck_run == 1
    return
  endif
  let g:typecheck_run = 1
  call setqflist([])
  let l:dir = finddir('.git/..', expand('%:p:h').';')
  if l:dir != ""
    echo "Typechecking " l:dir
    let l:cmd = ['npx', 'tsc', '--noEmit', '--pretty', '--noErrorTruncation']
    let g:issues = []
    if a:async
      let l:job_id = jobstart(l:cmd, {'on_stdout': function('HandleOutput'), 'on_stderr': function('HandleOutput'), 'on_exit': function('HandleOutput')})
    else
      let l:result = systemlist(join(l:cmd, ' '))
      call HandleOutput(0, l:result, 'stdout')
      call HandleOutput(0, [], 'exit')
    endif
    if a:open_quickfix
      copen
    endif
  endif
endfunction

command! Tsc call TypeCheck(1, 0)
autocmd BufWritePost * call TypeCheck(0, 1)

" testing
let test#strategy = "dispatch"
let g:test#neovim#start_normal = 1
let g:coc_global_extensions = ['coc-solargraph']

" fzf config
let g:fzf_layout = { 'window': 'tabnew' }
let g:fzf_preview_window = ['up:40%']
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'String'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'fg+':     ['fg', 'Directory', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Directory', 'CursorColumn'],
  \ 'info':    ['fg', 'Keyword'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Statement'],
  \ 'pointer': ['fg', 'Directory'],
  \ 'marker':  ['fg', 'Directory'],
  \ 'spinner': ['fg', 'Label'],
  \ 'preview-bg':  ['bg', 'CursorColumn'],
  \ 'header':  ['fg', 'Comment'] }

" startify
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 1

" Blamer
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_prefix = ' ◼︎ '

" Neovide
let g:neovide_cursor_vfx_mode = "railgun"
let g:neovide_refresh_rate=120
let g:neovide_cursor_animation_length=0.13
set guifont=JetBrains\ Mono:h14

" Syntax highlighting group under the cursor
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)                                       
	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

" Rhubarb Gbrowse
let g:github_enterprise_urls = ['https://github.cbhq.net']

if !exists('g:vscode')
  augroup numbertoggle
	autocmd!
	autocmd VimEnter,WinEnter,BufWinEnter * set number relativenumber
	autocmd WinLeave * set norelativenumber nonumber
    augroup END
endif

" Lightline + Coc integration
if !exists('g:vscode')
    function! StatusDiagnostic() abort
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif
      let msgs = []
      if get(info, 'error', 0)
        call add(msgs, info['error'] . ' Errors')
      endif
      if get(info, 'warning', 0)
        call add(msgs, info['warning'] . ' Warnings')
      endif
      return join(msgs, ' ')
    endfunction
endif

let g:lightline = {
        \   'colorscheme': 'onedark',
        \   'active': {
        \     'left': [ [ 'mode', 'paste' ],
        \               [ 'readonly', 'gitbranch', 'relativepath', 'coc', 'gutentags', 'modified' ] ]
        \   },
		\   'component': {},
        \   'component_function': {
        \     'gitbranch': 'FugitiveHead',
        \     'gutentags': 'gutentags#statusline',
        \     'coc':       'StatusDiagnostic'
        \   },
        \ }

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
  autocmd WinLeave * setlocal nocursorline nocursorcolumn
augroup END

if has('linebreak')
   set breakindent
   let &showbreak = '⤷ '
   set cpo+=n
endif

" Make *.ts => typescript, *.tsx => typescript.tsx
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx,*.jsx setlocal filetype=typescript.tsx

" Prettier (for plain vim only)
if !has('nvim') && !exists('g:vscode')
    autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
endif

" 256-color fix
if &term =~ '256color'
    set t_ut=
endif

" gutentags config
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = ['--tag-relative=yes', '--fields=+ailmnS']
let g:gutentags_ctags_exclude = [
\  '*.git', '*.svn', '*.hg',
\  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
\  '*.d.ts*',
\  '*-lock.json', '*.lock',
\  '*.min.*',
\  '*.bak',
\  '*.zip',
\  '*.pyc',
\  '*.class',
\  '*.sln',
\  '*.csproj', '*.csproj.user',
\  '*.tmp',
\  '*.cache',
\  '*.vscode',
\  '*.pdb',
\  '*.exe', '*.dll', '*.bin',
\  '*.mp3', '*.ogg', '*.flac',
\  '*.swp', '*.swo',
\  '.DS_Store', '*.plist',
\  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
\  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
\  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
\]

" Watchbuild
autocmd User CocNvimInit call CocAction('runCommand', 'tsserver.watchBuild')

" Commands
command! Rc e $MYVIMRC
command! Sorc so $MYVIMRC
command! Vimrc so $MYVIMRC
command! Conflicts Ag<<<<<<

" Vertical Split Buffer
function VerticalSplitBuffer(buffer)
    execute "vert belowright sb" a:buffer 
endfunction

command! -nargs=1 Vsb call VerticalSplitBuffer(<f-args>)

" Utility functions
function! FillLine(str)
    let tw = 80
    if tw==0 | let tw = 80 | endif
    .s/[[:space:]]*$//
    let reps = (tw - col("$")) / len(a:str)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction

autocmd TextYankPost * execute 'OSCYankRegister ' . v:event.regname

" Copilot
let g:copilot_no_tab_map = v:true

" IndentLine
let g:indentLine_char = '▏'

" Terminal colors
set termguicolors
set t_Co=256 

" Always use system register
set clipboard=unnamedplus

" coc.nvim config (neovim only)
if has('nvim') && !exists('g:vscode')
    let g:coc_global_extensions = [
				\ 'coc-tslint-plugin',
				\ 'coc-tsserver',
				\ 'coc-emmet',
				\ 'coc-css',
				\ 'coc-html',
				\ 'coc-json',
				\ 'coc-yank',
				\ 'coc-eslint',
				\ ]

	" Diff in vertical mode
	set diffopt=internal,filler,vertical
    set hidden
    set nobackup
    set nowritebackup
    set cmdheight=2
    set updatetime=300
    set shortmess+=c
    set signcolumn=yes

    highlight CocErrorFloat ctermfg=red
    highlight CocWarningFloat ctermfg=yellow
    highlight CocInfoFloat ctermfg=white
    highlight CocHintFloat ctermfg=white

    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    inoremap <silent><expr> <c-space> coc#refresh()

    if has('patch8.1.1068')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

	" Navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    nnoremap <silent> K :call <SID>show_documentation()<CR>
    nnoremap <nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
    nnoremap <nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
    inoremap <nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming
    nmap <leader>rn :CocCommand document.renameCurrentWord<CR>

	" Formatting
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <space>ac  <Plug>(coc-codeaction)
    nmap <space>qf  <Plug>(coc-fix-current)

    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    command! -nargs=0 Format :call CocAction('format')
	command! -nargs=? Fold :call CocAction('fold', <f-args>)
	command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
    command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
endif

" Mappings _____________________________________________________________________
map <silent> <space>- :call FillLine('_')<CR>
map <silent> \h :call SynGroup()<CR>
map <silent> <space>o :Files<CR>
map <silent> <space>p :Format<CR>
map <silent> <space>b :bn<CR>
map <silent> <space>B :Buffers<CR>
map <silent> <space>f :BLines<CR>
map <silent> <space>F :Tags<CR>
map <silent> <space>i :CocList diagnostics<CR>
map <silent> <space>w :up<bar>bp<bar>sp<bar>bn<bar>bd<CR>
map <silent> <space>j :call CocAction('diagnosticNext')<CR>
map <silent> <space>k :call CocAction('diagnosticPrevious')<CR>
nnoremap <silent> <space>t :TestFile<CR>
nnoremap <silent> <space>T :TestNearesPt<CR>
map <silent> <C-h> xh
inoremap <silent><script><expr> <C-l> copilot#Accept("")
imap <silent> <C-j> <Plug>(copilot-next)
imap <silent> <C-k> <Plug>(copilot-previous)
imap <silent> <C-\> <Plug>(copilot-dismiss)
map <silent> <space><CR> <Plug>(coc-fix-current)
map <silent> <space>\ <Plug>(coc-codeaction)
map <silent> <space>O :CocList mru<CR>
map <silent> ,w <Plug>CamelCaseotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge
map <silent> <space>n :noh<CR>
map <silent> <space>/ :CocList outline<CR>
map <silent> Tt :tabnew<CR>
map <silent> Tj :tabnext<CR>
map <silent> Tk :tabprev<CR>
map <silent> Tw :tabclose<CR>
map <silent> TT :tabn 
map <silent> <space>y :CocList yank<CR>
nnoremap <space>gd :vert sp \| wincmd l \| execute "normal! gd"<CR>
nnoremap <space>vs :vert sp \| wincmd l<CR>
nnoremap <space>sp :sp \| wincmd j<CR>
nnoremap <silent> ;c :AvanteChat<CR>
nnoremap <silent> ;t :AvanteToggle<CR>

" Neoscroll
lua << EOF
require('neoscroll').setup({
  mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
              '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
  hide_cursor = false,
  stop_eof = true,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
	easing_function = 'cubic',
  pre_hook = nil,
  post_hook = nil,
  performance_mode = true,
})
EOF
