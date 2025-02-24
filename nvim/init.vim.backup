


" This vimrc attempts to be nvim/vim agnostic, but it's a better experience in
" nvim.


" git-plug plugin manager ______________________________________________________
"
if has('nvim') " we are nvim bl

    call plug#begin(stdpath('data') . '/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'} 

else " we are plain old vim

    " because plain old vim doesn't change the cursor
    " shape for us in insert mode
    let &t_SI.="\e[5 q" "SI = INSERT mode
    let &t_SR.="\e[4 q" "SR = REPLACE mode
    let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

    call plug#begin('~/.vim/plugged')
" Plug 'peitalin/vim-jsx-typescript'

endif


Plug 'jparise/vim-graphql'
Plug 'APZelos/blamer.nvim'
Plug 'vim-scripts/lightline'
Plug 'yuezk/vim-js'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mhinz/vim-startify'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rhubarb' " enabled GBrowse
Plug 'tpope/vim-dispatch'
Plug 'lilyball/vim-swift'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'justinmk/vim-sneak'
Plug 'jph00/swift-apple'
Plug 'mattn/emmet-vim'
Plug 'hallzy/lightline-onedark'
Plug 'alvan/vim-closetag'
Plug 'airblade/vim-gitgutter'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jamestthompson3/nvim-remote-containers'
Plug 'vim-test/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'github/copilot.vim'
Plug 'evanleck/vim-svelte'
Plug 'fcpg/vim-osc52'


" post install (yarn install | npm install) then load plugin only for editing
" supported files
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()

" Theme stuff __________________________________________________________________

set termguicolors

"
"
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    " set t_8f=[38;2;%lu;%lu;%lum
    " set t_8b=[48;2;%lu;%lu;%lum
    set termguicolors
  endif
endif

" *cterm-colors*

" NR-16   NR-8    COLOR NAME 
" 0       0       Black
" 1       4       DarkBlue
" 2       2       DarkGreen
" 3       6       DarkCyan
" 4       1       DarkRed
" 5       5       DarkMagenta
" 6       3       Brown, DarkYellow
" 7       7       LightGray, LightGrey, Gray, Grey
" 8       0*      DarkGray, DarkGrey
" 9       4*      Blue, LightBlue
" 10      2*      Green, LightGreen
" 11      6*      Cyan, LightCyan
" 12      1*      Red, LightRed
" 13      5*      Magenta, LightMagenta
" 14      3*      Yellow, LightYellow
" 15      7*      White

colorscheme clarity

" highlight Pmenu ctermbg=DarkGray guibg=DarkGray ctermfg=White guifg=White
" highlight PmenuSel ctermbg=DarkCyan guibg=DarkCyan ctermfg=Black guifg=Black
" highlight PmenuThumb ctermbg=Yellow guibg=Yellow
" highlight PmenuSbar ctermbg=Black guibg=Black
highlight CocCodeLens guifg=#505050 
" highlight Cursor guibg=DarkCyan
" highlight CocHighlightText guibg=#104040 ctermbg=222
set guicursor=n-v-c:block-Cursor/lCursor-blinkon5000-blinkoff50-blinkwait100,i-ci-cr:Cursor-ver20-blinkon2000-blinkoff50-blinkwait100

" Settings _____________________________________________________________________
"
set laststatus=2 " needed for lightline
set shell=zsh\ -i
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set noshowmode " disables -- INSERT -- which is provided by lightline
set wrap
set linebreak
set list listchars=tab:»·,trail:·
set ls=2
set noequalalways
set shell=/bin/bash

" Config _______________________________________________________________________
"
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" au FileType go nmap \ds <Plug>(go-def-split)
" au FileType go nmap \dv <Plug>(go-def-vertical)
" au FileType go nmap \dt <Plug>(go-def-tab)

" testing
let test#strategy = "dispatch"
let g:test#neovim#start_normal = 1 " If using neovim strategy
" let test#javascript#jest#options = "--color=always"


let g:coc_global_extensions = ['coc-solargraph']

" let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1, 'border': 'top' } }
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

let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 1

" let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
" let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx,*.ts'
" let g:closetag_regions = {
"     \ 'typescript.tsx': 'jsxRegion,tsxRegion',
"     \ 'javascript.jsx': 'jsxRegion',
"     \ 'typescriptreact': 'jsxRegion,tsxRegion',
"     \ 'javascriptreact': 'jsxRegion',
"     \ }
" let g:closetag_shortcut = '>'
" let g:closetag_close_shortcut = '<leader>>'
" let g:closetag_filetypes = 'html,xhtml,phtml'
" let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" " Change the color of current & background windows
" function! s:configure_winhighlight()
"   let ft = &filetype
"   let bt = &buftype
"   " Check white/blacklist.
"   if index(['dirvish'], ft) == -1
"         \ && (index(['nofile', 'nowrite', 'acwrite', 'quickfix', 'help'], bt) != -1
"         \     || index(['startify'], ft) != -1)
"     set winhighlight=Normal:MyNormalWin,NormalNC:MyNormalWin
"     " echom "normal" winnr() &winhighlight 'ft:'.&ft 'bt:'.&bt
"   else
"     set winhighlight=Normal:MyNormalWin,NormalNC:MyInactiveWin
"     " echom "inactive" winnr() &winhighlight 'ft:'.&ft 'bt:'.&bt
"   endif
" endfunction
" augroup inactive_win
"   au!
"   au ColorScheme * hi link MyInactiveWin ColorColumn | hi link MyNormalWin Normal
"   au FileType,BufWinEnter * call s:configure_winhighlight()
"   au FocusGained * hi link MyNormalWin Normal
"   au FocusLost * hi link MyNormalWin MyInactiveWin
" augroup END

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
function!SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
            echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
        endfun


" Rhubarb Gbrowse
let g:github_enterprise_urls = ['https://github.cbhq.net']

if !exists('g:vscode')
  augroup numbertoggle
      autocmd!
      autocmd VimEnter,WinEnter,BufWinEnter     * set number relativenumber
      autocmd WinLeave                          * set norelativenumber nonumber
    augroup END
endif

" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.

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
        \   'component': {
        \   },
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
 end

" by default .ts file are not identified as typescript and .tsx files are not
" identified as typescript react file, so add following
" https://medium.com/@s1n7ax/neovim-for-typescript-react-development-fdc7082c8a78
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx,*.jsx setlocal filetype=typescript.tsx


" prettier runs after existing insert
"
if !has('nvim') && !exists('g:vscode')
    autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
endif

" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
if &term =~ '256color'
    set t_ut=
endif

" move tags to a single directory
" let g:gutentags_trace = 1
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root  = ['package.json', '.git']
" Add these to the above for Mercurial and SVN: '.hg', '.svn'
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
\  '*-lock.json',  '*.lock',
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
" build and populate errors on change
autocmd User CocNvimInit call CocAction('runCommand', 'tsserver.watchBuild')

" Commands _____________________________________________________________________
"
command! Rc e $MYVIMRC
command! Sorc so $MYVIMRC
command! Conflicts Ag<<<<<<

" Vertical Split Buffer Function
function VerticalSplitBuffer(buffer)
    execute "vert belowright sb" a:buffer 
endfunction

" Vertical Split Buffer Mapping
command! -nargs=1 Vsb call VerticalSplitBuffer(<f-args>)

" Utility functions ____________________________________________________________
"

" fill to end of line using —
function! FillLine( str )
    " set tw to the desired total length
    let tw = 80
    if tw==0 | let tw = 80 | endif
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction

" osc52 support
if has('textyankpost')
    augroup BlinkClipboardIntegration
        autocmd!
        " For some reason '*' doesn't show up in the clipboard names, so using
        " 'cy, instead '*y as used expect
        autocmd TextYankPost * if v:event.regname == 'c' | call SendViaOSC52(join(v:event["regcontents"],"\n")) | endif
    augroup END
endif

" coc.nvim config

if has('nvim') && !exists('g:vscode')

    " coc extensions
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
    
    " Set diffs to vertical
    set diffopt=internal,filler,vertical

    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes

    highlight CocErrorFloat ctermfg=red
    highlight CocWarningFloat ctermfg=yellow
    highlight CocInfoFloat ctermfg=white
    highlight CocHintFloat ctermfg=white

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if has('patch8.1.1068')
      " Use `complete_info` if your (Neo)Vim version supports it.
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    " scroll nvim popups
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

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    " nmap <leader>rn <Plug>(coc-rename)
    nmap <leader>rn :CocCommand document.renameCurrentWord<CR>

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current line.
    nmap <space>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <space>qf  <Plug>(coc-fix-current)

    " Introduce function text object
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <TAB> for selections ranges.
    " NOTE: Requires 'textDocument/selectionRange' support from the language server.
    " coc-tsserver, coc-python are the examples of servers that support it.
    " nmap <silent> <TAB> <Plug>(coc-range-select)
    " xmap <silent> <TAB> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

    " Mappings using CoCList:
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    " nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    " nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    " nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

endif


" Mappings _____________________________________________________________________
"
" map <C-n> :NERDTreeToggle<CR>
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
nnoremap <silent> <space>T :TestNearest<CR>
map <silent> <C-h> xh
map <silent> <C-CR> :Copilot<CR>
imap <silent> <C-j> <Plug>(copilot-next)
imap <silent> <C-k> <Plug>(copilot-previous)
imap <silent> <C-\> <Plug>(copilot-dismiss)
map <silent> <space><CR> <Plug>(coc-fix-current)
map <silent> <space>\ <Plug>(coc-codeaction)
map <silent> <space>O :CocList mru<CR>
map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge
map <silent> <space>n :noh<CR>
map <silent> <space>/ :CocList outline<CR>
map <silent> Tt :tabnew<CR>
map <silent> Tn :tabnext<CR>
map <silent> Tp :tabprev<CR>
map <silent> Tw :tabclose<CR>
map <silent> <space>y :CocList yank<CR>
