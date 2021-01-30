" "                      _____ _____ _____ _   _   ___  ___  ___
"       ▄█    █▄     ▄██████▄     ▄██████▄   ▄█     █▄     ▄████████    ▄████████     ███        ▄████████
"      ███    ███   ███    ███   ███    ███ ███     ███   ███    ███   ███    ███ ▀█████████▄   ███    ███
"      ███    ███   ███    ███   ███    █▀  ███     ███   ███    ███   ███    ███    ▀███▀▀██   ███    █▀
"     ▄███▄▄▄▄███▄▄ ███    ███  ▄███        ███     ███   ███    ███  ▄███▄▄▄▄██▀     ███   ▀   ███
"    ▀▀███▀▀▀▀███▀  ███    ███ ▀▀███ ████▄  ███     ███ ▀███████████ ▀▀███▀▀▀▀▀       ███     ▀███████████
"      ███    ███   ███    ███   ███    ███ ███     ███   ███    ███ ▀███████████     ███              ███
"      ███    ███   ███    ███   ███    ███ ███ ▄█▄ ███   ███    ███   ███    ███     ███        ▄█    ███
"      ███    █▀     ▀██████▀    ████████▀   ▀███▀███▀    ███    █▀    ███    ███    ▄████▀    ▄████████▀
"                                                                      ███    ███

" URL: https://github.com/whatyouhide/vim-gotham
" Aurhor: Andrea Leopardi <an.leopardi@gmail.com>
" Version: 1.0.0
" License: MIT


" Bootstrap ===================================================================

hi clear
if exists('syntax_on') | syntax reset | endif
set background=dark
let g:colors_name = 'hogwarts'


" Helper functions =============================================================

" Execute the 'highlight' command with a List of arguments.
function! s:Highlight(args)
  exec 'highlight ' . join(a:args, ' ')
endfunction

function! s:AddGroundValues(accumulator, ground, color)
  let new_list = a:accumulator
  for [where, value] in items(a:color)
    call add(new_list, where . a:ground . '=' . value)
  endfor

  return new_list
endfunction

function! s:Col(group, fg_name, ...)
  " ... = optional bg_name

  let pieces = [a:group]

  if a:fg_name !=# ''
    let pieces = s:AddGroundValues(pieces, 'fg', s:colors[a:fg_name])
  endif

  if a:0 > 0 && a:1 !=# ''
    let pieces = s:AddGroundValues(pieces, 'bg', s:colors[a:1])
  endif

  call s:Clear(a:group)
  call s:Highlight(pieces)
endfunction

function! s:Attr(group, attr)
  let l:attrs = [a:group, 'term=' . a:attr, 'cterm=' . a:attr, 'gui=' . a:attr]
  call s:Highlight(l:attrs)
endfunction

function! s:Clear(group)
  exec 'highlight clear ' . a:group
endfunction


" Colors ======================================================================

" Let's store all the colors in a dictionary.
let s:colors = {}

" Base colors.
let s:colors.base0 = { 'gui': '#141413', 'cterm': 234 }  " background
let s:colors.base1 = { 'gui': '#262626', 'cterm': 235 }  " line background
let s:colors.base2 = { 'gui': '#585858', 'cterm': 240 }  " comment
let s:colors.base3 = { 'gui': '#bcbcbc', 'cterm': 250 }  " normal text
let s:colors.base4 = { 'gui': '#8599a6', 'cterm': 12 }  " light blue
let s:colors.base5 = { 'gui': '#1e6479', 'cterm': 13 }  " light purple
let s:colors.base6 = { 'gui': '#bc9e7f', 'cterm': 10 }  " light yellow
let s:colors.base7 = { 'gui': '#d3ebe9', 'cterm': 9 }  " light red TODO: replace

" Other colors.
let s:colors.red     = { 'gui': '#c23127', 'cterm': 1  }
let s:colors.orange  = { 'gui': '#d26937', 'cterm': 9  }
let s:colors.yellow  = { 'gui': '#edb443', 'cterm': 3  }
let s:colors.magenta = { 'gui': '#888ca6', 'cterm': 5 }
let s:colors.violet  = { 'gui': '#4e5166', 'cterm': 5  }
let s:colors.blue    = { 'gui': '#195466', 'cterm': 4  }
let s:colors.cyan    = { 'gui': '#33859E', 'cterm': 6  }
let s:colors.green   = { 'gui': '#2aa889', 'cterm': 2  }

" Neovim :terminal colors.
let g:terminal_color_0  = get(s:colors.base0, 'gui')
let g:terminal_color_8  = g:terminal_color_0
let g:terminal_color_1  = get(s:colors.red, 'gui')
let g:terminal_color_9  = g:terminal_color_1
let g:terminal_color_2  = get(s:colors.green, 'gui')
let g:terminal_color_10 = g:terminal_color_2
let g:terminal_color_3  = get(s:colors.yellow, 'gui')
let g:terminal_color_11 = g:terminal_color_3
let g:terminal_color_4  = get(s:colors.blue, 'gui')
let g:terminal_color_12 = g:terminal_color_4
let g:terminal_color_5  = get(s:colors.violet, 'gui')
let g:terminal_color_13 = g:terminal_color_5
let g:terminal_color_6  = get(s:colors.cyan, 'gui')
let g:terminal_color_14 = g:terminal_color_6
let g:terminal_color_7  = get(s:colors.base6, 'gui')
let g:terminal_color_15 = g:terminal_color_7


" Native highlighting ==========================================================

let s:background = 'base0'
let s:linenr_background = 'base1'

" Everything starts here.
call s:Col('Normal', 'base3', s:background)

" Line, cursor and so on.
call s:Col('Cursor', 'base1', 'base6')
call s:Col('CursorLine', '', 'base1')
call s:Col('CursorColumn', '', 'base1')

" Sign column, line numbers.
call s:Col('LineNr', 'base2', s:linenr_background)
call s:Col('CursorLineNr', 'base6', s:linenr_background)
call s:Col('SignColumn', '', s:linenr_background)
call s:Col('ColorColumn', '', s:linenr_background)

" Visual selection.
call s:Col('Visual', '', 'base4')

" Easy-to-gu
call s:Col('Comment', 'base2')
call s:Col('String', 'base4')
call s:Col('Number', 'base6')
call s:Col('Statement', 'yellow')
call s:Col('Special', 'cyan')
call s:Col('Delimiter', 'base4')
call s:Col('Identifier', 'yellow')
call s:Col('Function', 'red')

" Constants, Ruby symbols.
call s:Col('Constant', 'red')

" Some HTML tags (<title>, some <h*>s)
call s:Col('Title', 'red')

" <a> tags.
call s:Col('Underlined', 'yellow')
call s:Attr('Underlined', 'underline')

" Types, HTML attributes, Ruby constants (and class names).
call s:Col('Type', 'yellow')

" Stuff like 'require' in Ruby.
call s:Col('PreProc', 'yellow')

" Tildes on the bottom of the page.
call s:Col('NonText', 'blue')

" Concealed stuff.
call s:Col('Conceal', 'cyan', s:background)

" TODO and similar tags.
call s:Col('Todo', 'base3', 'violet')

" The column separating vertical splits.
call s:Col('VertSplit', 'blue', s:linenr_background)
call s:Col('StatusLineNC', 'blue', 'base2')

" Matching parenthesis.
call s:Col('MatchParen', 'base6', 'base2')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
call s:Col('SpecialKey', 'base3')

" Folds.
call s:Col('Folded', 'base6', 'blue')
call s:Col('FoldColumn', 'base5', 'base1')

" Searching.
call s:Col('Search', 'base2', 'yellow')
call s:Attr('IncSearch', 'reverse')

" Popup menu.
call s:Col('Pmenu', 'base6', 'base2')
call s:Col('PmenuSel', 'red', 'blue')
call s:Col('PmenuSbar', '', 'base2')
call s:Col('PmenuThumb', '', 'blue')

" Command line stuff.
call s:Col('ErrorMsg', 'red', 'base1')
call s:Col('Error', 'red', 'base1')
call s:Col('ModeMsg', 'blue')
call s:Col('WarningMsg', 'red')

" Wild menu.
" StatusLine determines the color of the non-active entries in the wild menu.
call s:Col('StatusLine', 'base5', 'base2')
call s:Col('WildMenu', 'red', 'cyan')

" The 'Hit ENTER to continue prompt'.
call s:Col('Question', 'green')

" Tab line.
call s:Col('TabLineSel', 'base0', 'base6')  " the selected tab
call s:Col('TabLine', 'base6', 'base1')     " the non-selected tabs
call s:Col('TabLineFill', 'base0', 'base0') " the rest of the tab line

" Spelling.
call s:Col('SpellBad', 'base3', 'red')
call s:Col('SpellCap', 'base3', 'blue')
call s:Col('SpellLocal', 'yellow')
call s:Col('SpellRare', 'base7', 'violet')

" Diffing.
call s:Col('DiffAdd', 'base3', 'green')
call s:Col('DiffChange', 'base3', 'blue')
call s:Col('DiffDelete', 'base3', 'red')
call s:Col('DiffText', 'base3', 'cyan')

" Directories (e.g. netrw).
call s:Col('Directory', 'cyan')


" Programming languages and filetypes ==========================================

" Ruby.
call s:Col('rubyDefine', 'blue')
call s:Col('rubyStringDelimiter', 'green')

" HTML (and often Markdown).
call s:Col('htmlArg', 'blue')
call s:Col('htmlItalic', 'magenta')
call s:Col('htmlBold', 'cyan', '')

" Python
call s:Col('pythonStatement', 'blue')


" Plugin =======================================================================

" GitGutter
call s:Col('GitGutterAdd', 'green', s:linenr_background)
call s:Col('GitGutterChange', 'cyan', s:linenr_background)
call s:Col('GitGutterDelete', 'orange', s:linenr_background)
call s:Col('GitGutterChangeDelete', 'magenta', s:linenr_background)

" CtrlP
call s:Col('CtrlPNoEntries', 'base7', 'orange') " no entries
call s:Col('CtrlPMatch', 'green')               " matching part
call s:Col('CtrlPPrtBase', 'blue')             " '>>>' prompt
call s:Col('CtrlPPrtText', 'cyan')              " text in the prompt
call s:Col('CtrlPPtrCursor', 'base7')           " cursor in the prompt

" unite.vim
call s:Col('UniteGrep', 'base7', 'green')
let g:unite_source_grep_search_word_highlight = 'UniteGrep'

" ale https://github.com/w0rp/ale
call s:Col('ALEWarningSign', 'yellow', s:linenr_background)
call s:Col('ALEErrorSign', 'red', s:linenr_background)

" neomake https://github.com/neomake/neomake
call s:Col('NeomakeWarningSign', 'yellow', s:linenr_background)
call s:Col('NeomakeErrorSign', 'red', s:linenr_background)
call s:Col('NeomakeWarning', 'yellow')
call s:Col('NeomakeError', 'red')

" Defx
call s:Col('Defx_filename_directory', 'base3')

" Link highlight gropus
hi! link vimContinue Comment
hi! link vimFuncSID vimFunction
hi! link vimFuncVar Normal
hi! link vimFunction Title
hi! link vimGroup Statement
hi! link vimHiGroup Statement
hi! link vimHiTerm Identifier
hi! link vimMapModKey Special
hi! link vimOption Identifier
hi! link vimVar Normal


"" Cleanup =====================================================================

unlet s:colors
unlet s:background
unlet s:linenr_background
