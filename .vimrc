"--------------------------
" VSCode Color like Scheme
"--------------------------
set background=dark
autocmd FileType * setlocal formatoptions-=ro

if version > 580
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif

syntax on

set t_Co=256
let g:colors_name = "VSCode like theme"

" 背景・標準文字
hi Normal ctermbg=234

" タブ
hi TabLineSel ctermfg=15 ctermbg=27 cterm=bold

" 変数
hi Identifier ctermfg=39 cterm=bold
"hi Identifier ctermfg=105 cterm=bold

" 関数名
"hi Function ctermfg=187 cterm=bold
hi Function ctermfg=27 cterm=bold

" コメント
hi Comment term=bold ctermfg=241

" 文字列
hi String ctermfg=173
hi Character ctermfg=173
hi Number ctermfg=173
hi Float ctermfg=173

" Bool
hi Boolean ctermfg=69

" 変数型
hi Type ctermfg=120

" ステータスライン
hi StatusLine ctermfg=15 ctermbg=27 cterm=NONE

" 同cterm上での新規タブステータスライン
hi StatusLineNC ctermfg=15 ctermbg=27 cterm=NONE

"hi PreProc ctermfg=246

" 行番号
hi LineNr cterm=NONE ctermfg=102

"-----------------------
" Backup
"-----------------------
"set backup
"set backupdir=.
"
"-----------------------
" Search
" -----------------------
set history=1000
set smartcase
set tags=
set hlsearch
set mouse-=a
" set incsearch
"-----------------------
" Vim-tags
"-----------------------
nnoremap <C-]> :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>

"-------------
" Custom Settings
"
" Vimのデフォルトキーバインドはうざいから
" それを回避するためのカスタムセッチング
"-------------

" Enter で挿入モード
nnoremap <silent> <CR> <Esc>i
" Ctrl + f でカーソルで指定した内容をヒットする
nnoremap <silent> <C-f> <Esc>#
" 普通モード中に Ctrl + a で現在行先頭に移動
nnoremap <silent> <C-a> <Esc>^
" 普通モード中に Ctrl + d で現在行末に移動
nnoremap <silent> <C-d> <Esc>$
" 挿入モード中に Ctrl + a で現在行先頭に移動
inoremap <silent> <C-a> <Esc>^<Insert>
" 挿入モード中に Ctrl + d で現在行末に移動
inoremap <silent> <C-d> <Esc>$<Insert><Right>
" Switching previous tab with [1]
nnoremap 1 :tabprevious<CR>
" Switching next tab with [3]
nnoremap 3 :tabnext<CR>
" Create a new tab on the RIGHT side of current tab with [Space + t]
nnoremap <space>t :tabnew<space>
" If you want to create a new tab on the Left side of current tab,
" use 「 :tabnew xxx/xxx | tabmove -1 」


" Flags
let numberFlag = 0

" Switch ON line number
if numberFlag == 1
    " Show Line Number
    nnoremap <space>n :set number<CR>
    let numberFlag = 0
" Switch OFF
else
    " Hide Line Number
    nnoremap <space>n :set number!<CR>
    let numberFlag = 1
endif

" Redo code with [Ctrl + z] in any mode
nnoremap <C-z> :u<CR>
inoremap <C-z> <ESC> :u<CR>

" Save file with [Ctrl + s] in any mode
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC> :w<CR>

" Save and Close current tab with [Ctrl + w]
nnoremap <C-w> :wq<CR>

" カーソルを行末に移動
nnoremap <C-Right> :w
inoremap <C-Right> g$

" Turn off searching highlight
nnoremap <space>h :noh<CR>

" Reflash file with [Ctrl + r] in any mode
nnoremap <C-r> :e<CR>
inoremap <C-r> <ESC> :e<CR>

" Comment or uncomment lines from mark a to mark b.
" ビジュアルモードで、内容を選択して「\ + c」を押すとコメントアウトされます
"（「\ + 大文字 C」 →コメント外す）
function! CommentMark(docomment, a, b)
    if !exists('b:comment')
	let b:comment = CommentStr() . ' '
    endif
    if a:docomment
	exe "normal! '" . a:a . "_\<C-V>'" . a:b . 'I' . b:comment
    else
	exe "'".a:a.",'".a:b . 's/^\(\s*\)' . escape(b:comment,'/') . '/\1/e'
    endif
endfunction

" Comment lines in marks set by g@ operator.
function! DoCommentOp(type)
    call CommentMark(1, '[', ']')
endfunction

" Uncomment lines in marks set by g@ operator.
function! UnCommentOp(type)
    call CommentMark(0, '[', ']')
endfunction

" Return string used to comment line for current filetype.
function! CommentStr()
    if &ft == 'cpp' || &ft == 'java' || &ft == 'javascript'
	return '//'
    elseif &ft == 'vim'
	return '"'
    elseif &ft == 'python' || &ft == 'perl' || &ft == 'sh' || &ft == 'R' || &ft == 'ruby'
	return '#'
    elseif &ft == 'lisp'
	return ';'
    endif
	return ''
endfunction

nnoremap <Leader>c <Esc>:set opfunc=DoCommentOp<CR>g@<CR>
nnoremap <Leader>C <Esc>:set opfunc=UnCommentOp<CR>g@<CR>
vnoremap <Leader>c <Esc>:call CommentMark(1,'<','>')<CR>
vnoremap <Leader>C <Esc>:call CommentMark(0,'<','>')<CR>

" Save and Close current tab with [Ctrl + q]
"
" Linux上では、Ctrl+Qはデフォルトでプロセス中止となっているため、
" .bashrc では以下の記入が必要
"
" stty stop undef
" stty start undef
nnoremap <C-q> :wq<CR>

"カーソルの次の文字列を取得（引数は取得したい文字数）
function! GetNextString(length) abort
    let l:str = ""
    for i in range(0, a:length-1)
	let l:str = l:str.getline(".")[col(".")-1+i]
    endfor
    return l:str
endfunction

"カーソルの前の文字列を取得（引数は取得したい文字数）
function! GetPrevString(length) abort
    let l:str = ""
    for i in range(0, a:length-1)
	let l:str = getline(".")[col(".")-2-i].l:str
    endfor
    return l:str
endfunction

"アルファベットかどうかを取得
function! IsAlphabet(char) abort
    let l:charIsAlphabet = (a:char =~ "\a")
    return (l:charIsAlphabet)
endfunction

"全角かどうかを取得
function! IsFullWidth(char) abort
    let l:charIsFullWidth = (a:char =~ "[^\x01-\x7E]")
    return (l:charIsFullWidth)
endfunction

"数字かどうかを取得
function! IsNum(char) abort
    let l:charIsNum = (a:char >= "0" && a:char <= "9")
    return (l:charIsNum)
endfunction

"括弧の中にいるかどうかを取得
function IsInsideParentheses(prevChar,nextChar) abort
    let l:cursorIsInsideParentheses1 = (a:prevChar == "{" && a:nextChar == "}")
    let l:cursorIsInsideParentheses2 = (a:prevChar == "[" && a:nextChar == "]")
    let l:cursorIsInsideParentheses3 = (a:prevChar == "(" && a:nextChar == ")")
    return (l:cursorIsInsideParentheses1 || l:cursorIsInsideParentheses2 || l:cursorIsInsideParentheses3)
endfunction

"括弧の入力
function! InputParentheses(parenthesis) abort
    let l:nextChar = GetNextString(1)
    let l:prevChar = GetPrevString(1)
    let l:parentheses = { "{": "}", "[": "]", "(": ")" }
    let l:nextCharIsEmpty = (l:nextChar == "")
    let l:nextCharIsCloseParenthesis = (l:nextChar == "}" || l:nextChar == "]" || l:nextChar == ")")
    let l:nextCharIsSpace = (l:nextChar == " ")

    if l:nextCharIsEmpty || l:nextCharIsCloseParenthesis || l:nextCharIsSpace
	return a:parenthesis.l:parentheses[a:parenthesis]."\<LEFT>"
    else
	return a:parenthesis
    endif
endfunction

"閉じ括弧の入力
function! InputCloseParenthesis(parenthesis) abort
    let l:nextChar = GetNextString(1)
    if l:nextChar == a:parenthesis
	return "\<RIGHT>"
    else
	return a:parenthesis
    endif
endfunction

"クォーテーションの入力
function! InputQuot(quot) abort
    let l:nextChar = GetNextString(1)
    let l:prevChar = GetPrevString(1)

    let l:cursorIsInsideQuotes = (l:prevChar == a:quot && l:nextChar == a:quot)
    let l:nextCharIsEmpty = (l:nextChar == "")
    let l:nextCharIsClosingParenthesis = (l:nextChar == "}" || l:nextChar == "]" || l:nextChar == ")")
    let l:nextCharIsSpace = (l:nextChar == " ")
    let l:prevCharIsAlphabet = IsAlphabet(l:prevChar)
    let l:prevCharIsFullWidth = IsFullWidth(l:prevChar)
    let l:prevCharIsNum = IsNum(l:prevChar)
    let l:prevCharIsQuot = (l:prevChar == "\'" || l:prevChar == "\"" || l:prevChar == "\`")

    if l:cursorIsInsideQuotes
	return "\<RIGHT>"
    elseif l:prevCharIsAlphabet || l:prevCharIsNum || l:prevCharIsFullWidth || l:prevCharIsQuot
	return a:quot
    elseif l:nextCharIsEmpty || l:nextCharIsClosingParenthesis || l:nextCharIsSpace
	return a:quot.a:quot."\<LEFT>"
    else
	return a:quot
    endif
endfunction

"改行の入力
function! InputCR() abort
    let l:nextChar = GetNextString(1)
    let l:prevChar = GetPrevString(1)
    let l:cursorIsInsideParentheses = IsInsideParentheses(l:prevChar,l:nextChar)

    if l:cursorIsInsideParentheses
	return "\<CR>\<ESC>\<S-o>\<TAB>"
    else
	return "\<CR>"
    endif
endfunction

"スペースキーの入力
function! InputSpace() abort
    let l:nextChar = GetNextString(1)
    let l:prevChar = GetPrevString(1)
    let l:cursorIsInsideParentheses = IsInsideParentheses(l:prevChar,l:nextChar)

    if l:cursorIsInsideParentheses
	return "\<Space>\<Space>\<LEFT>"
    else
	return "\<Space>"
    endif
endfunction

"バックスペースの入力
function! InputBS() abort
    let l:nextChar = GetNextString(1)
    let l:prevChar = GetPrevString(1)
    let l:nextTwoString = GetNextString(2)
    let l:prevTwoString = GetPrevString(2)

    let l:cursorIsInsideParentheses = IsInsideParentheses(l:prevChar,l:nextChar)

    let l:cursorIsInsideSpace1 = (l:prevTwoString == "{ " && l:nextTwoString == " }")
    let l:cursorIsInsideSpace2 = (l:prevTwoString == "[ " && l:nextTwoString == " ]")
    let l:cursorIsInsideSpace3 = (l:prevTwoString == "( " && l:nextTwoString == " )")
    let l:cursorIsInsideSpace = (l:cursorIsInsideSpace1 || l:cursorIsInsideSpace2 || l:cursorIsInsideSpace3)

    let l:existsQuot = (l:prevChar == "'" && l:nextChar == "'")
    let l:existsDoubleQuot = (l:prevChar == "\"" && l:nextChar == "\"")

    if l:cursorIsInsideParentheses || l:cursorIsInsideSpace || l:existsQuot || l:existsDoubleQuot
	return "\<BS>\<RIGHT>\<BS>"
    else
	return "\<BS>"
    endif
endfunction

"括弧で挟む
function! ClipInParentheses(parenthesis) abort
    let l:mode = mode()
    let l:parentheses = { "{": "}", "[": "]", "(": ")" }
    if l:mode ==# "v"
	return "\"ac".a:parenthesis."\<ESC>\"agpi".l:parentheses[a:parenthesis]
    elseif l:mode ==# "V"
	return "\"ac".l:parentheses[a:parenthesis]."\<ESC>\"aPi".a:parenthesis."\<CR>\<ESC>\<UP>=%"
    endif
endfunction

"クォーテーションで挟む
function! ClipInQuot(quot) abort
    let l:mode = mode()
    if l:mode ==# "v"
	return "\"ac".a:quot."\<ESC>\"agpi".a:quot
    endif
endfunction

inoremap <expr> { InputParentheses("{")
inoremap <expr> [ InputParentheses("[")
inoremap <expr> ( InputParentheses("(")
inoremap <expr> } InputCloseParenthesis("}")
inoremap <expr> ] InputCloseParenthesis("]")
inoremap <expr> ) InputCloseParenthesis(")")
inoremap <expr> ' InputQuot("\'")
inoremap <expr> " InputQuot("\"")
inoremap <expr> ` InputQuot("\`")
inoremap <expr> <CR> InputCR()
inoremap <expr> <Space> InputSpace()
inoremap <expr> <BS> InputBS()
xnoremap <expr> { ClipInParentheses("{")
xnoremap <expr> [ ClipInParentheses("[")
xnoremap <expr> ( ClipInParentheses("(")
xnoremap <expr> ' ClipInQuot("\'")
xnoremap <expr> " ClipInQuot("\"")
xnoremap <expr> ` ClipInQuot("\`")


"-----------------------
" Display
"-----------------------
set laststatus=2
set showmatch
set hlsearch
set wildmenu
set lcs=tab:>.,trail:_,extends:\
set virtualedit=onemore
let g:netrw_liststyle=3 "ディレクトリ構造をtree形式で表示する

"set list
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /シ」シ」/

"-----------------------
" Indent
"-----------------------
set autoindent
set cindent
set nocindent
set noexpandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

set smartindent

"-----------------------
" Encoding
" 日本語を含まない場合は fileencoding に encoding を使うようにする
"-----------------------
if has('autocmd')
    function! AU_ReCheck_FENC()
	if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
	    let &fileencoding=&encoding
	endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif

function! SetStatusLine()
    return '%F%m%r%h%w %=%Y %{&ff} %{&fenc} %l:%L '
endfunction

"set statusline+=%F%m%r%h%w\ %=%Y\ \ \%{&ff}\ \ \%{&fileencoding}\ \ \%l:%L
set statusline+=%!SetStatusLine()

"-----------------------
""" Compiler
"-----------------------
"""aiq:q:qutocmd FileType pl,perl,cgi :compiler perl
" compiler perl
