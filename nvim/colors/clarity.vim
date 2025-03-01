"Name:          clarity
"Version:       1.0

" ----------------------------------------------------
" Global Setup
"----------------------------------------------------
set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="clarity"

"----------------------------------------------------
" Base Colors (Vim Built-in Groups)
" These groups are provided by Vim by default.
"----------------------------------------------------
hi Normal       guifg=#a5e9ff     guibg=#18304d

hi DiffDelete   guifg=#304050     guibg=#203040
hi DiffAdd      guibg=#002851
hi DiffChange   guifg=#450303
hi DiffText     guifg=#990909     gui=none

hi diffAdded    guifg=#00bf00     guibg=#1d2c1b
hi diffRemoved  guifg=#e00000     guibg=#2d1c20

"----------------------------------------------------
" UI Elements (Built-in and Plugin-defined Groups)
" These groups control the appearance of interface 
" elements.
"----------------------------------------------------

" Cursor line number (current line number)
hi CursorLineNr guifg=#60A1D8     guibg=#18304d
" Text cursor appearance
hi Cursor       guibg=#ffbd00     guifg=#13233c
" Directory names in listings
hi Directory    guifg=#a6e22e
" Fold column appearance
hi FoldColumn   guibg=grey30      guifg=tan
" Folded text appearance
hi Folded       guifg=#cccccc     guibg=#405060
" Incremental search highlighting
hi IncSearch    guifg=slategrey   guibg=khaki
" Line numbers in the gutter
hi LineNr       guifg=#4382CB     guibg=#18304d
" Mode message display (e.g., -- INSERT --)
hi ModeMsg      guifg=goldenrod
" More text indicator
hi MoreMsg      guifg=SeaGreen
" Non-text characters (e.g., end-of-line markers)
hi NonText      guifg=#304050     guibg=#18304d
" Prompt for user input
hi Question     guifg=springgreen
" Search result highlighting
hi Search       guibg=#ffff7d     guifg=#000000
" Sign column for marks, breakpoints, etc.
hi SignColumn   guifg=#a6e22e     guibg=#18304d
" Special keys display
hi SpecialKey   guifg=yellowgreen
" Active status line
hi StatusLine   guibg=#102030     guifg=grey70    gui=none
" Inactive status line
hi StatusLineNC guibg=#1e3855     guifg=grey50    gui=none
" Window/buffer titles
hi Title        guifg=indianred
" Vertical split divider
hi VertSplit    guibg=#102030     guifg=#102030   gui=none
" Visual selection highlighting
hi Visual       guifg=white       guibg=#f62a00   gui=none
" Warning messages
hi WarningMsg   guifg=salmon

" Inline Diagnostics
hi DiagnosticError    guifg=#FF6347 guibg=#2a4565 gui=italic
hi DiagnosticWarn     guifg=#FbD300 guibg=#2a4565 gui=italic
hi DiagnosticInfo     guifg=#60A1D8 guibg=#2a4565 gui=italic
hi DiagnosticHint     guifg=#70d080 guibg=#2a4565 gui=italic

"----------------------------------------------------
" Syntax Highlighting (Standard Vim Syntax Groups)
" These standard groups are used for comments, constants, identifiers, etc.
"----------------------------------------------------

hi Comment    guifg=#8f9ae5   gui=italic
hi Constant   guifg=#ecad2b   gui=none
hi Delimiter  guifg=#8090a0
hi Identifier guifg=#70d080   gui=none
hi Ignore     guifg=grey40    gui=none
hi Number     guifg=#ecad2b
hi PreProc    guifg=indianred gui=none
hi Special    guifg=#ecad2b   gui=none
hi Statement  guifg=#5fa1db   gui=none
hi Todo       guifg=orangered guibg=#304050 gui=none
hi Type       guifg=#8cd0d3   gui=none

"----------------------------------------------------
" Text and Popup Colors (Built-in Vim Groups)
" These groups affect text highlights and pop-up menus.
"----------------------------------------------------

" Diagnostic popup
hi NormalFloat  guibg=#2A1A05 guibg=#18304d
hi FloatBorder  guifg=#ecad2b guibg=#18304d

hi String       guifg=#fb5baa     guibg=none

hi PMenuSel gui=standout,bold
if version >= 700
    hi CursorLine   guifg=NONE    guibg=#304E73 gui=underline,bold
    hi CursorColumn guifg=NONE    guibg=#304E73 gui=NONE
    hi MatchParen   guifg=#304050 guibg=cyan gui=BOLD
    hi Pmenu        guifg=#f6f3e8 guibg=#152535 gui=NONE
    hi PmenuSel     guifg=#000000 guibg=#cae682 gui=NONE
endif

if version >= 703
    hi ColorColumn  guifg=#e8ecf0 guibg=#283848
endif

"----------------------------------------------------
" Snacks.nvim Colors (Defined by Snacks.nvim plugin)
"----------------------------------------------------

" Text color of a file ln a listing
hi SnacksPickerFile                 guifg=#ffffff gui=none
" The text color folder in a listing
hi SnacksPickerDirectory            guifg=#8cd0d3 gui=none
" The text color of the path part of a listing
hi SnacksPickerDir                  guifg=#70c7ea gui=none
" The text color in search boxes
hi SnacksPickerCursorLine           guifg=#fefefe gui=none
" The text color of pane titles
hi SnacksPickerTitle                guifg=#ffe000 gui=none
" The color of hidden files
hi SnacksPickerPathHidden           guifg=#8f9ae5 gui=none

" Box line color of listing panels
hi SnacksPickerBoxBorder            guifg=#8f9ae5 gui=none
" Separator line between search and listing
hi SnacksPickerInputBorder          guifg=#8f9ae5 gui=none
" Separator line of preview panels
hi SnacksPickerPreviewBorder        guifg=#8f9ae5 gui=none
" The selection color
hi SnacksPickerListCursorLine       guifg=#ffe381 guibg=#3D5560
" The selection color in preview windows
hi SnacksPickerPreviewCursorLine    guifg=#2A1A05 guibg=#ecad2b
" The color of the path part of file listings on the dashboard
hi SnacksDashboardDir               guifg=#4382CB

"----------------------------------------------------
" Noice.nvim Colors (Defined by Noice.nvim plugin)
"----------------------------------------------------

hi NoiceConfirm                     guifg=#a5e9ff guibg=#18304d
hi NoiceFormatConfirm               guifg=#fefeff guibg=#304E73

"----------------------------------------------------
" vim-easymotion
"----------------------------------------------------
"
hi EasyMotionTarget guifg=#ffe381 gui=bold
hi EasyMotionTarget2First guifg=#ecad2b gui=bold
hi EasyMotionTarget2Second guifg=#fb5baa gui=bold
hi EasyMotionShade guifg=#8090a0 guibg=none
hi EasyMotionIncSearch guifg=#70d080 guibg=#18304d
hi EasyMotionMoveHL guifg=#a5e9ff guibg=#304E73


"----------------------------------------------------
" GitSigns.nvim Colors (Defined by GitSigns.nvim plugin)
"----------------------------------------------------

hi GitSignsCurrentLineBlame guifg=#60A1D8
