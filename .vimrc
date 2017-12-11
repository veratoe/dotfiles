"" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-bufferline'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-syntastic/syntastic'
call vundle#end()

filetype plugin indent on

"" Kleurtjes
syntax enable
colorscheme pablo
hi Comment ctermfg=0 term=NONE cterm=BOLD
hi LineNr ctermfg=0 term=BOLD cterm=BOLD
hi CursorLineNr ctermfg=1 term=BOLD cterm=BOLD
hi CursorLine cterm=NONE term=NONE
hi String ctermfg=3 term=NONE cterm=NONE
hi DiffDelete ctermbg=none ctermfg=0
hi DiffAdd ctermbg=green ctermfg=white
hi DiffChange ctermbg=NONE
hi MatchParen cterm=underline,bold ctermfg=red ctermbg=none
hi Visual ctermbg=13
hi Pmenu ctermfg=8 ctermbg=0
hi PmenuSel ctermfg=7 ctermbg=0 cterm=bold

"" HTML tagging
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'smarty' : 1
    \}

set tabstop=4     "" tab op 4 spaties
set shiftwidth=4  "" tab 4 spatietjes
set expandtab
set list          "" geheime characters tonen, om indentatie CHI conform te zien
set listchars=trail:~,extends:>,precedes:<,tab:^T,

"" diede meuk
set number          "" regelnummers aan
set ignorecase      "" case insensitive zoeken
set incsearch       "" gelijk zoeken na typen letters
set hlsearch        "" zoektermen highlighten
set nowrap          "" irritante wrappen uitzetten
set sidescroll=1    "" verspringen scrollen zijkant uitzetten
set hidden          "" ongesavede buffers kunnen hebben
set laststatus=2    "" atlijd statusline tonen


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 1

"" sommige JSHint foutmeldingen onderdrukken
let g:syntastic_javascript_jshint_quiet_messages = {
    \ 'regex': '\VExpected an assignment'
    \ }

noremap <Tab> :bnext<CR>
noremap <S-Tab> :bprev<CR>

noremap { <NOP>
noremap } <NOP>

let s:prevcountcache=[[], 0]
function! ShowCount()
    let key=[@/, b:changedtick]
    if s:prevcountcache[0]==#key
        return s:prevcountcache[1]
    endif
    let s:prevcountcache[0]=key
    let s:prevcountcache[1]=0
    let pos=getpos('.')
    try
        let result=""
        redir => subscount
        silent %s///gne
        redir END
        let d=matchstr(subscount, '\d\+')
        if d==''
        else
            let result="'"
            let result.=substitute(key[0], '[<>\\]', '', "g")
            let result.="': "
            let result.=d
            let result.=" hits"
        endif
        let s:prevcountcache[1]=result
        return result
    finally
        call setpos('.', pos)
    endtry
endfunction

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

let g:bufferline_echo = 0
autocmd VimEnter *
    \ let &statusline='%#PmenuSel#%{StatuslineGit()}%#LineNr# %{bufferline#refresh_status()}' .bufferline#get_status_string() .'%m %= %{ShowCount()} %y [%l:%L]' 

,
