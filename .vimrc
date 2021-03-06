set nocompatible " Be Improved


function! IsWin32()
  return has("win32unix") || has("win32") " Cygwin || Regular Win32
endfunction

function! IsUnix()
  return !IsWin32()
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     Vundle settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Linting
Plugin 'dense-analysis/ale'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'

" Colors
Plugin 'flazz/vim-colorschemes'

Plugin 'tikhomirov/vim-glsl'

" Javascript
" Plugin 'isRuslan/vim-es6'
" Plugin 'pangloss/vim-javascript'

" CPP
Plugin 'octol/vim-cpp-enhanced-highlight'

" Rust
Plugin 'rust-lang/rust.vim'

" Utilities
" Plugin 't9md/vim-quickhl'          " On they fly keyword highlighting

Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
"Plugin 'sirver/ultisnips'
Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'

" Shit that's so good it should be illegal. God bless Tim Pope
" Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
" Plugin 'tpope/vim-dispatch'        " Don't think this works on WIN32 ..?

" Rails
" Plugin 'tpope/vim-rake'
" Plugin 'tpope/vim-bundler'

" Colors
" Plugin 'altercation/vim-colors-solarized'
Plugin 'jaromero/vim-monokai-refined'
" Plugin 'digitaltoad/vim-jade'
" Plugin 'ap/vim-css-color'

if IsUnix()
  " Plugin 'scrooloose/syntastic'    " This doesn't work with MSVC.. standard.
  " Plugin 'omnisharp/omnisharp-vim' " Not currently using this on WIN32
  " Plugin 'dag/vim-fish'            " Fish filetype detection, among others
endif

" Plugin 'vim-scripts/autoclose'


call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Misc Custom Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allows file type detection for plugins with Vim and allows automatic
" indentation
filetype plugin indent on

syntax enable
syntax on

set background=dark

colorscheme Monokai-Refined
" colorscheme solarized

" High contrast dark theme
" colorscheme Tomorrow-Night-Blue

" Lower contrast dark theme
" colorscheme Tomorrow-Night-Eighties

" Lowest contrast dark theme
" colorscheme Tomorrow-Night

" Pastel dark themes
" colorscheme bvemu

" Muted dark themes
" colorscheme badwolf
" colorscheme blazer

" Left off here
" colorscheme charged-256

" colorscheme babymate256

" Start GVim maximized
au GUIEnter * simalt ~x

" Remove the GUI tool bar and menubar
if has("gui_running")
    set guioptions-=T
    set guioptions-=m
endif


highlight clear SignColumn

" Clear background
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

highlight markdownError ctermbg=NONE

" Clear underline on Tabs
highlight TabLine cterm=NONE ctermbg=NONE
highlight TabLineSel term=standout
highlight TabLineFill term=NONE cterm=NONE

" Cursor line and matching bracket
highlight MatchParen ctermfg=magenta ctermbg=NONE
highlight CursorLineNr ctermfg=magenta ctermbg=NONE

highlight LineNr ctermfg=12 ctermbg=NONE
highlight SpecialKey ctermfg=10 ctermbg=NONE cterm=NONE
highlight folded cterm=bold ctermbg=NONE ctermfg=10

" Spelling background corrections are annoying
highlight SpellBad ctermbg=NONE cterm=underline
highlight SpellRare ctermbg=NONE
highlight SpellLocal ctermbg=NONE
highlight SpellCap ctermbg=NONE

highlight Comment ctermfg=180 guifg=#868686

" When :set spell
highlight SpellBad ctermbg=NONE term=bold,underline cterm=bold,underline

highlight Comment ctermfg=180

highlight CursorLine ctermbg=238
highlight ColorColumn ctermbg=238

" Indent highlighting, among others
highlight SpecialKey guifg=grey ctermfg=8 ctermbg=NONE cterm=NONE


highlight link diffAdded DiffAdd
highlight link diffRemoved DiffDelete

highlight DiffAdd ctermfg=green cterm=NONE
highlight DiffAdd ctermbg=NONE

highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE
highlight Folded ctermbg=NONE

highlight cErrInBracket ctermbg=NONE
highlight htmlError ctermbg=NONE

" Make the cursor line readable in diff-mode
autocmd filetype diff highlight clear CursorLine

set t_Co=256

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                                WIN32 CONFIG
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if IsWin32()
  " Source a TIL function
  " TODO: This should probably eventually do a recursive traversal of til/vim/*
  " and source everything in that directory.
  source ~/til/vim/sanitize-svn-diff.vim

  " Set ft to diff for svn_diff.tmp
  autocmd BufNewFile,BufRead .svn_diff.tmp set ft=diff
  autocmd BufNewFile,BufRead .svn-commit.tmp set ft=diff

  let $TMP="~/AppData/Local/Temp"
  set shell=c:\\tools\\cygwin\\bin\\bash.exe

  " Should this be on all platforms?
  set guifont=Consolas:h11:cANSI

  set grepprg=ack.cmd

  set ttymouse=xterm2

" Ignore trailing \r characters - Windows, I'm looking at you.
" match Ignore /\r$/

  nmap <Leader>p :!~/til/workflow/push_static_assets.sh<cr><cr>

  " Get some reasonable syntax highlighting in .tpl files.
  autocmd BufNewFile,BufRead *.tpl set ft=r

  " Set random IBM i filetypes
  " Shamelessly stolen from "http://www.dbg400.net/foswiki/bin/view/DBG400/EditingWithVim"
  augroup filetypedetect
    au! BufRead,BufNewFile *.rpg          setfiletype rpg
    au! BufRead,BufNewFile *.rpgle        setfiletype rpgle
    au! BufRead,BufNewFile *.clp          setfiletype clp
    au! BufRead,BufNewFile *.dspf         setfiletype dds
    au! BufRead,BufNewFile *.prtf         setfiletype dds
    au! BufRead,BufNewFile *.pf           setfiletype dds
    au! BufRead,BufNewFile *.lf           setfiletype dds
    au! BufRead,BufNewFile *.sqlcpp       setfiletype cpp
    au! BufRead,BufNewFile *.axlsx        setfiletype ruby
  augroup END

  " Open current file in VS
  nmap <silent> <leader>ed :call DevEnvEdit()<CR>

  map <leader>eb :tabe ~/.bash_profile<CR>
  map <leader>ep :tabe ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1<CR>
  map <leader>eh :tabe ~/.hotkeys.ahk<CR>
  map <leader>ec :tabe /Cygwin.bat<CR>


  " Counterpart to the GBlame() command from tpope
  function! SBlame()
    let current_cursor = getcurpos()
    let cursor_line = current_cursor[1]

    " Center the screen
    call setpos('.', current_cursor)

    call RunShellCommand('svn blame %')

    let blame_cursor = getcurpos()
    let blame_cursor[1] = cursor_line

    " echo current_cursor
    " echo blame_cursor

    call setpos('.', blame_cursor)

    windo set scrollbind
  endfunction


  function! DevEnvEdit()
    !devenv.com /Edit %
  endfunction

  if !exists("*VSBuild")
    function VSBuild()
      make silent
      copen
    endfunction
  endif

  "
  "  Visual studio settings
  "

  " Display errors in a vsplit, and don't open new buffers
  set switchbuf=useopen

  set makeprg=build.sh
  " set errorformat+=\\\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %m

else

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                                  UNIX CONFIG
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " Use spaces instead of tabs
  set expandtab
  set ttymouse=urxvt

  if filereadable("./make.sh")
    set makeprg=./make.sh
  elseif filereadable("./scripts/make.sh")
    set makeprg=./scripts/make.sh
  endif

  set grepprg=ack

endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                                 COMMON CONFIG
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if filereadable("./Cargo.toml")
  set makeprg=cargo\ build
endif

" Typescript - lifted from https://github.com/leafgarland/typescript-vim
set errorformat+=%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m


" Toggle background colors ..?
" call togglebg#map("<F9>")

" This hides buffers instead of closing them
" No more saving before you ,,
" no more lost history and marks when you ,,
" MUST HAVE!
set hidden
set autowrite

" Change leader to ,
let mapleader=','

" Do not cosider the $ character to be a word boundary
set iskeyword+=$

" Setting for eclim/YCM completion
let g:EclimCompletionMethod = 'omnifunc'

" Axe swap and backup flies
" http://jeffkreeftmeijer.com/2010/git-your-act-together/
set nobackup
set noswapfile

" Automatically read in changed files with no annoying prompt
set autoread

" Show relative line numbers
set relativenumber
" except for the line the cursor is on - show the actual line number
set number

" Set tabs to 2 spaces
set tabstop=2
set shiftwidth=2


" Backspace over space-tabs
set softtabstop=2
" Backspace over normal stuff
set backspace=indent,eol,start

" Since I'm a wildman
set wildmenu

" Don't redraw the screen in the middle of a macro
set lazyredraw

" show trailing whitespace, tabs and lines extending off the page
set list
set listchars=tab:\│\ ,trail:.,extends:#,nbsp:.

" No word wrapping at edge of window
set nowrap

" Keep cursor in same column when jumping from file to file
set nostartofline

set colorcolumn=80
set cursorline

" Map 'K' to jump to help topics
set keywordprg=:help

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
" map N Nzz
" map n nzz


" Set Vimperatorrc as vimfile
autocmd BufNewFile,BufRead .vimperatorrc set ft=vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:syntastic_cpp_compiler_options  = "-DDEBUG=1 -I./external/glm-0.9.7.1/ -I./src/ -I./src/GL/ -I./src/datatypes/"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                      Ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_linters = {}
let g:ale_linters['haskell'] = ['hlint', 'ghc']

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier', 'eslint']
let g:ale_fixers['typescript'] = ['tslint', 'prettier', 'eslint']
let g:ale_fixers['haskell'] = ['hfmt']

let g:ale_javascript_eslint_use_global = 0

let g:ale_set_highlights = 0
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign

" easily jump between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <Leader>p :ALEFix<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noruler
set laststatus=2 " Always show the status line

" Powerline font
let g:airline_powerline_fonts = 1

" Enable the Tabline!
let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Quickhl.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight QuickhlCword ctermfg=81 cterm=underline

nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

nmap <Space>j <Plug>(quickhl-cword-toggle)
nmap <Space>] <Plug>(quickhl-tag-toggle)
map H <Plug>(operator-quickhl-manual-this-motion)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     Keymaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" esc insert mode
imap jk <esc>

" break <C-c>; it doesn't fire InsertLeave autocommands, which is bad apparently
" http://valloric.github.io/YouCompleteMe/#faq
"
" Looks like I've broken the habit, now this is just annoying
" map <C-c> <esc>iStopit<esc>

" Compiler Error nav etc.
nmap <C-n> :cn<CR>zO
nmap <C-b> :cp<CR>zO

" Quick-switch between source and header
nmap <leader>h :call SwitchSourceHeader()<CR>

nmap <leader>t :CtrlPTag<cr>


""""""""""""""""""""""""""""""""""""""""
"      Quick Edit Conf files
""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <Leader>ev :tabe ~/.vimrc<CR>

nnoremap <silent> <Leader>ez :tabe ~/.zshrc<CR>

" hotkeys
nnoremap <silent> <Leader>eh :tabe ~/.sxhkdrc<CR>

nnoremap <silent> <Leader>ex :tabe ~/.Xresources<CR>

" lemonbar stuff
nnoremap <silent> <Leader>ep :tabe ~/.lemonbar/panel<CR>

nnoremap <silent> <Leader>ew :tabe ~/.bspwmrc<CR>

" Today I learned
nnoremap <leader>et           :tabe ~/til/<CR>

" Random .env stuff
nnoremap <leader>ee           :tabe ~/.env<CR>

nnoremap <leader>eg           :tabe ~/.gdbinit<CR>

" snippets file
nnoremap <silent> <Leader>es :UltiSnipsEdit<CR>

""""""""""""""""""""""""""""""""""""""""
"              Utility
""""""""""""""""""""""""""""""""""""""""

" Save all buffers and a vim Session in pwd
nnoremap <silent> <Leader>S :wa<CR>:mksession!<CR>

" Save current buffer
nnoremap <silent> <Leader>s :w<CR>

" Open Gblame
nnoremap <Leader>gb :Gblame<CR>

" Next buffer
nnoremap <Leader>n :bn<CR>

" Last buffer
nnoremap <Leader>b :bprev<CR>

" Save a file with sudo
cnoremap w!! w !sudo tee %

" buffer toggle
nnoremap <Leader><Leader> <C-^>

" set ,d to delete current file
nnoremap <Leader>d :call delete(expand('%'))<CR>

nnoremap <Leader>q :call ToggleQuickfix()<CR>

function! Todos()
  if filereadable("./scripts/todo.sh")
    cexpr system('./scripts/todo.sh')
    let g:qfix_win = bufnr("$")
    copen
  endif
endfunction

function! ToggleQuickfix()
  if exists("g:qfix_win")
    cclose
    unlet g:qfix_win
  else
    copen
    wincmd J
    let g:qfix_win = bufnr("$")
  endif
endfunction

function! ClearRegs()
  " Cannot clear . : % registers this way for some reason
  let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"+*#', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
endfunction



" Maven clean/build
" map <F4> :Mvn clean<CR>
map <F5> :Mvn clean package<CR>
map <F6> :Mvn clean package<CR>:Java<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                      Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set foldmethod=syntax
set foldlevelstart=99

" Quicker toggle entire fold
map zz zA

set fdo-=search " only search in open folds

" let javaScript_fold=1         " JavaScript

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                      Splitting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set splitbelow
set splitright

nnoremap <C-w>h <C-w>h:call BufResize()<CR>
nnoremap <C-w>l <C-w>l:call BufResize()<CR>
nnoremap <C-w>j <C-w>j:call BufResize()<CR>
nnoremap <C-w>k <C-w>k:call BufResize()<CR>
nnoremap <C-w><C-h> <C-w>h:call BufResize()<CR>
nnoremap <C-w><C-l> <C-w>l:call BufResize()<CR>
nnoremap <C-w><C-j> <C-w>j:call BufResize()<CR>
nnoremap <C-w><C-k> <C-w>k:call BufResize()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     Tabbing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <C-l> :tabnext<CR>:call BufResize()<CR>
nnoremap <C-h> :tabprevious<CR>:call BufResize()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Incsearch searches the document for a string each time a character is added
" to the string
set incsearch
" Search Highlighting is annoying
set hlsearch

" Ignores case sensitivity when searching for a string
set ignorecase
" If your search string is mixed case smartcase will only match that exact
" string
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Ultisnips Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" My vim hasn't been compiled with python3 support;
" force ultisnips to use python2
let g:UltiSnipsUsePythonVersion = 2

" Set trigger combo to ctrl-j
let g:UltiSnipsExpandTrigger="<c-f>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-F>"

" Set UltiSnipEdit to open in a vertical split
let g:UltiSnipsEditSplit = 'vertical'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Ctrl-P Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ctrlp uses vims wildignore to ignore directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/.stack-work/*,*/bin/*,*/build/CMakeFiles/*,*/build/CMakeCache.txt,*/build/cmake_install.cmake,*/build/Makefile,*/fonts/*,*tmp/grunt*

let g:ctrlp_follow_symlinks = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['Gemfile', 'node_modules', 'package.json', '.root-dir']

let g:ctrlp_use_caching = 0

" Do not limit the number of files to index
let g:ctrlp_max_files = 0

" Index .files
let g:ctrlp_dotfiles = 1

" let g:ctrlp_switch_buffer = 0
" let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
 let g:ctrlp_custom_ignore = {
    \ 'dir':'\v[\/]\.git$|.*/cache|node_modules|.meteor|vendor|ngrok|composer.lock|_site|.sass-cache',
    \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     LaTeX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Force grep to display filenames even when searching through a single file
" This has something to do with autocomplete in latex

" So empty .tex files still load vim-latex
let g:tex_flavor='latex'

"let g:Tex_CompileRule_pdf = 'pdflatex --interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_ViewRule_pdf = 'fbpdf'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Filetype Specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd   BufNewFile,BufRead   *.scss        set   ft=css
autocmd   BufNewFile,BufRead   *.dae         set   ft=xml
autocmd   BufNewFile,BufRead   *.mustache    set   ft=html
autocmd   BufNewFile,BufRead   *.deface      set   ft=html
autocmd   BufNewFile,BufRead   sxhkdrc       set   ft=sh
autocmd   BufNewFile,BufRead   Vagrantfile   set   ft=ruby
autocmd   BufNewFile,BufRead   *Xresource*   set   ft=xdefaults
" autocmd   BufNewFile,BufRead   *ts           set   ft=javascript
" autocmd   BufNewFile,BufRead   *tsx          set   ft=javascript
autocmd   BufNewFile,BufRead   *ts           set   makeprg=./make.sh
autocmd   BufNewFile,BufRead   *tsx          set   makeprg=./make.sh
autocmd   BufNewFile,BufRead   *twig         set   ft=html
autocmd   BufNewFile,BufRead   *shader       set   ft=glsl

" Reloads vim when the .vimrc gets modified
" autocmd BufWritePost ~/.vimrc so %

" Reload BSPWM when we write to config file
" autocmd BufWritePost bspwmrc call RunShellCommand('~/.config/bspwm/bspwmrc')

" Compile my resume when I save it
autocmd BufWritePost resume.* ! node render.js --sample
autocmd BufWritePost recent_experience.* ! node render.js --sample

" Ruby and Rails autocomplete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     Ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searches for tags file in current folder and works its way up to
" root looking for one.
set tags=./tags;/

set linebreak

" Current file directory expansion
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>

" Spell Check
setlocal spell spelllang=en_us

" The minimum number of lines to show above/below the cursor
set scrolloff=7

" toggles between set paste && set nopaste
" paste mode disables autoindenting so you can paste shit into vim happily
set pastetoggle=<F2>

set clipboard=unnamed

set mouse=a

" Enable persistent undo
set undofile
set undodir=~/.undofiles




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Custom Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline

  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif

     " Always quote filepaths expanded with %
     if part[0] =~ '%'
        let expanded_part = '"' . fnameescape(expand(part)) . '"'
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor

  topleft vnew
  setlocal buftype=nofile "bufhidden=wipe nobuflisted noswapfile nowrap
  setlocal scrolloff=999
  " call setline(1, 'You entered:    ' . a:cmdline)
  " call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  " call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read ! '. expanded_cmdline
  " setlocal nomodifiable
  1
endfunction

function! FormatJSON()
  execute '%!python -m json.tool' | w
endfunction
" Get highlight group for character under cursor.
map <leader>z :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

function! SwitchSourceHeader()
  "update!
  if (expand ("%:e") == "cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction

function! BufResize()
  vertical res 120
endfunction

" Strip trailing whitespace
function! StripWS()
  :%s/\s\+$//e
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                CSCOPE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open CScope results in quickfix window for easy jumping.
set cscopequickfix=s-,c-,d-,i-,t-,e-

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              STOCK CSCOPE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE:
" -- vim 6:			Stick this file in your ~/.vim/plugin directory (or in a
"								'plugin' directory in some other directory that is in your
"								'runtimepath'.
"
" -- vim 5:			Stick this file somewhere and 'source cscope.vim' it from
"								your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell				jduell@alumni.princeton.edu			2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose

    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "		's'		symbol: find all references to the token under cursor
    "		'g'		global: find global definition(s) of the token under cursor
    "		'c'		calls:	find all calls to the function name under cursor
    "		't'		text:		find all instances of the text under cursor
    "		'e'		egrep:	egrep search for the word under cursor
    "		'f'		file:		open the filename under cursor
    "		'i'		includes: find files that include the filename under cursor
    "		'd'		called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.	One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).	The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "		 nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.	If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    set timeoutlen=300
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    set ttimeout
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.	If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif
