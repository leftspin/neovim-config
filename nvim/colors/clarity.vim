"Name:          clarity
"Version:       1.0

set background=dark
if version > 580
    "no guarantees for version 5.8 and below, but this makes it stop complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="clarity"

hi Normal         guifg=#a5e9ff     guibg=#18304d

hi DiffDelete   guifg=#304050     guibg=#203040
hi DiffAdd      guibg=#002851
hi DiffChange   guibg=#450303
hi DiffText     guibg=#990909     gui=none

hi diffAdded    guifg=#00bf00     guibg=#1d2c1b
hi diffRemoved  guifg=#e00000     guibg=#2d1c20

hi Cursor       guibg=#ffbd00     guifg=#13233c
hi VertSplit    guibg=#102030     guifg=#102030   gui=none
hi Folded       guifg=#cccccc     guibg=#405060
hi FoldColumn   guibg=grey30      guifg=tan
hi IncSearch    guifg=slategrey   guibg=khaki
hi LineNr       guifg=#556575     guibg=#203040
hi ModeMsg      guifg=goldenrod
hi MoreMsg      guifg=SeaGreen
hi NonText      guifg=#304050     guibg=#18304d
hi Question     guifg=springgreen
hi Search       guibg=#ffff7d     guifg=#000000
hi SpecialKey   guifg=yellowgreen
hi StatusLine   guibg=#102030     guifg=grey70    gui=none
hi StatusLineNC guibg=#203040     guifg=grey50    gui=none
hi Title        guifg=indianred
hi Visual       guifg=white       guibg=#f62a00   gui=none
hi WarningMsg   guifg=salmon
hi Directory    guifg=#a6e22e
hi SignColumn   guifg=#a6e22e     guibg=#18304d
hi LineNr       guifg=#3b5989     guibg=#18304d

" hi String       guifg=ffe381     guibg=none
hi String       guifg=#fb5baa     guibg=none

hi PMenuSel gui=standout,bold
if version >= 700 " Vim 7.x specific colors
    hi CursorLine   guifg=NONE    guibg=#304E73 gui=underline,bold
    hi CursorColumn guifg=NONE    guibg=#304E73 gui=NONE
    " hi CursorColumn guifg=NONE    guibg=#1E3C61 gui=NONE
    hi MatchParen   guifg=#304050 guibg=cyan gui=BOLD
    hi Pmenu        guifg=#f6f3e8 guibg=#152535 gui=NONE
    hi PmenuSel     guifg=#000000 guibg=#cae682 gui=NONE
endif

if version >= 703 " Vim 7.x specific colors
    hi ColorColumn  guifg=#e8ecf0 guibg=#283848
endif

" syntax highlighting groups
hi Comment    guifg=#7e8bc2   gui=none
hi Constant   guifg=#ffe381   gui=none
hi Identifier guifg=#70d080   gui=none
hi Statement  guifg=#4b8bc3   gui=none
" hi Statement  guifg=# 3b6ba3   gui=none
hi PreProc    guifg=indianred gui=none
hi Type       guifg=#8cd0d3   gui=none
hi Special    guifg=#ecad2b   gui=none
hi Delimiter  guifg=#8090a0
hi Number     guifg=#ffff80
hi Ignore     guifg=grey40    gui=none
hi Todo       guifg=orangered guibg=#304050 gui=none

hi jsxElement guifg=white gui=none
hi jsxTag guifg=white gui=none
hi jsxTagName guifg=white gui=none
hi jsxString guifg=white gui=none
hi jsxCloseTag guifg=white gui=none
hi jxCloseString guifg=white gui=none
hi jsxDot guifg=white gui=none
hi jsxNamespace guifg=white gui=none
hi jsxPunct guifg=white gui=none
hi jsxBraces guifg=#a5e9ff guibg=none

" tags
hi jsxComponentName     guifg=#fb5baa gui=bold
hi jsxOpenPunct         guifg=#fb5baa gui=bold
hi jsxClosePunct        guifg=#fb5baa gui=bold
hi jsxCloseString       guifg=#fb5baa gui=bold
hi jsxAttrib            guifg=#f258a4 gui=italic
hi jsxEqual             guifg=#f258a4 gui=none
hi jsxBraces            guifg=#f258a4 gui=none
hi jsxString            guifg=#ffe381 guibg=none
hi jsxDot               guifg=#f258a4 gui=none

hi jsFunctionCall       guifg=#ff9f59 gui=none
hi jsComment            guifg=#7f4e66 gui=none
hi jsArrow              guifg=#ff9f59 gui=none

hi jsObjectKey          guifg=#82d567 guibg=none gui=italic
hi jsObjectBraces       guifg=#a5e9ff guibg=none
hi jsAssignmentColon    guifg=#82d567 guibg=none
hi jsComma              guifg=#82d567 guibg=none
hi jsDot                guifg=#82d567 guibg=none

" keywords
hi typescriptImport         guifg=#4b8bc3 gui=italic guibg=none
hi typescriptExport         guifg=#4b8bc3 gui=italic guibg=none
hi typescriptTry            guifg=#4b8bc3 gui=italic guibg=none
hi typescriptExceptions     guifg=#4b8bc3 gui=italic guibg=none
hi typescriptCastKeyword    guifg=#4b8bc3 gui=italic

hi typescriptInterfaceKeyword   guifg=#82d567 guibg=none gui=none
hi typescriptInterfaceName      guifg=#82d567 guibg=none gui=bold

hi typescriptMember             guifg=#4d8b38 gui=italic
hi typescriptMemberOptionality  guifg=#4d8b38 gui=bold

hi typescriptTypeReference guifg=#82d567 gui=none
hi typescriptTypeBrackets  guifg=#82d567 gui=none

hi typescriptBraces                 guifg=#a5e9ff gui=none
hi typescriptDestructureVariable    guifg=#a5e9ff gui=none
hi typescriptVariable               guifg=#F2836B gui=none
hi typescriptDocTags                guifg=#4b8bc3 gui=italic
hi typescriptDocNotation            guifg=#4b8bc3 gui=italic
hi typescriptOperator               guifg=#4b8bc3 gui=italic
hi typescriptAliasDeclaration       guifg=#82d567 guibg=none gui=bold,italic
hi typescriptAliasKeyword           guifg=#82d567 guibg=none gui=none
hi typescriptOptionalMark           guifg=#a5e9ff guibg=none gui=bold

" functions and blocks
hi typescriptCall                   guifg=#a5e9ff guibg=none
    hi typescriptArrowFunc          guifg=#55dbff gui=none
hi typescriptFuncTypeArrow          guifg=#55dbff gui=none
hi typescriptBlock                  guifg=#55dbff gui=none
hi typescriptFuncName               guifg=#55dbff gui=bold
hi typescriptParens                 guifg=#55dbff gui=none

" objects
hi typescriptObjectLabel            guifg=#84bacc guibg=none gui=italic
hi typescriptObjectColon            guifg=#84bacc guibg=none gui=none
hi typescriptObjectLiteral          guifg=#84bacc guibg=none gui=none

" types
hi typescriptNull                   guifg=#ffe381 gui=none
hi typescriptNumber                 guifg=#ffe381 gui=none
hi typescriptPredefinedType         guifg=#ffe381 gui=none

"vim: sw=4
