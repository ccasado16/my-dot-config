"*****************************************************************************
"" VimPlug Installation
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
let curl_exists=expand('curl')

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif



"*****************************************************************************
"" Plug install packages zone
"*****************************************************************************
" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'windwp/nvim-autopairs'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-scripts/CSApprox'
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'projekt0n/github-nvim-theme'
Plug 'ryanoasis/vim-devicons'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" nvim-autopairs (nvim 0.7 >)
lua << EOF
require("nvim-autopairs").setup {}
EOF


"" indentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = "inc"
let g:indentLine_char = "┆"
let g:indentLine_faster = 1


"" lightLine
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'], 
      \             ['filetype'] ],
      \   'right': [ ['percent'], ['lineinfo'], ['fileencoding', 'fileformat'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
      \ },
      \ 'component_function': {
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }  


function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction


"" NERDTree 
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
" have same NERDTree on every tab
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif


"" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1


"" github nvim theme
let g:github_comment_style = "italic"
let g:github_keyword_style = "italic"
let g:github_function_style = "italic"
let g:github_variable_style = "italic"



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set how many lines of history NVIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Set mapleader to ,
let mapleader=","

" Fast saving
nmap <leader>w :w!<cr>

" Enable mouse support
set mouse=a
set mousemodel=popup

 " Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif



""""""""""""""""""""""""""""""""""""
" => Nvim user interface
""""""""""""""""""""""""""""""""""""
" Turn on the wild menu
set wildmenu

" Always show current position
set ruler
set cursorline

" Height of the command line
set cmdheight=1

" Ignore case when searching
set ignorecase

" When searching try to be smart  about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in moderm browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" Add a bit extra margin to the left
set foldcolumn=0

" Set line relative numbers
set relativenumber

" Configure backspace so it acts as it should act
set backspace=indent,eol,start
set whichwrap+=<,>,h,l



" ====================================
" => Colors and Fonts
" ====================================
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
	set t_Co = 256
endif

set background=dark

try
	colorscheme github_dark
catch
	echo "there's no colorscheme"
endtry


" Set utf8 as standard enconding 
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac



" ===============================
" => Files, backups and undo
" ==============================
" Turn backup and swap off
set nobackup
set nowb
set noswapfile



" ===============================
" => Text, buffers, tab and indent related
" ==============================
" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Be smart when using tabs
set smarttab

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines



" ================================
" => Visual mode related
" ================================
" Visual mode pressing * or # searches for the current selectionv
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR> " down 
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR> " up



" ===========================================
" => Moving around, tabs, windows and buffers
" ===========================================
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Search mappings; These will make it so that going to the next one in a search
" will center on the line it's found in
nnoremap n nzzzv
nnoremap N Nzzzv

" Disable highlight when <leader><Space> is pressed
map <silent> <leader><Space> :noh<cr>

" Snart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>c :bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Next buffer
map <leader>x :bnext<cr>

" Previous buffer
map <leader>z :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tt :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
nnoremap <C-Right> :tabnext<cr>
nnoremap <C-Left> :tabprevious<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab=1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" useful when editiing
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/ 

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching betweens buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to the last edit position when opening files (NEEDED)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Folding
set foldmethod=manual



" =========================================
" => Status line
" "========================================
" Always show the status line
set laststatus=2
set noshowmode

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
"if exists("*fugitive#statusline")
"    set statusline+=%{"*fugitive#statusline"}
"else
"    set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)
"endif



""""""""""""""""""""""""""""""""""""""
" => Editing mappings
""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-black character
map 0 ^

" Move a line of text using ALT+[j/k] or ALT+[Up/Down]
nmap <M-k> mz:m-2<cr>`z
nmap <M-j> mz:m+<cr>`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z

nmap <M-Up> mz:m-2<cr>`z
nmap <M-Down> mz:m+<cr>`z
vmap <M-Up> :m'<-2<cr>`>my`<mzgv`yo`z
vmap <M-Down> :m'>+<cr>`<my`>mzgv`yo`z

" Delete trailing white spaces on save, useful for some filetypes
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.sql,*.sh,*.java :call CleanExtraSpaces()
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i



"""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""
" Presing ,ss will toggle and untoggles spell checking
map <leader>ss :setlocal spell!<cr>

" Shorcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=



""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""
" Remove the windows ^M - when the encondings gets messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble 
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Terminal emulation
nnoremap <silent> <leader>sh :terminal<cr>



"""""""""""""""""""""""""""""""""""""""""
" => Abbreviations
"""""""""""""""""""""""""""""""""""""""""
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry



"=================================================================================
"
"   Following file contains the commands on how to run the currently open code.
"   The default mapping is set to F5 like most code editors.
"   Change it as you feel comfortable with, keeping in mind that it does not
"   clash with any other keymapping.
"
"   NOTE: Compilers for different systems may differ. For example, in the case
"   of C and C++, we have assumed it to be gcc and g++ respectively, but it may
"   not be the same. It is suggested to check first if the compilers are installed
"   before running the code, or maybe even switch to a different compiler.
"
"   NOTE: Adding support for more programming languages
"
"   Just add another elseif block before the 'endif' statement in the same
"   way it is done in each case. Take care to add tabbed spaces after each
"   elseif block (similar to python). For example:
"
"   elseif &filetype == '<your_file_extension>'
"       exec '!<your_compiler> %'
"
"   NOTE: The '%' sign indicates the name of the currently open file with extension.
"         The time command displays the time taken for execution. Remove the
"         time command if you dont want the system to display the time
"
"=================================================================================

map <F5> :call CompileRun()<CR>
imap <F5> <Esc>:call CompileRun()<CR>
vmap <F5> <Esc>:call CompileRun()<CR>

func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %"
    elseif &filetype == 'sh'
        exec "!time bash %"
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'html'
        exec "!google-chrome % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'matlab'
        exec "!time octave %"
    endif
endfunc



"""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE'
    endif
    return ''
endfunction


" Don't close window, when deleting a buffer
command! Bclose call <SID>BufclosCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction


function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction


function! VisualSelection(direction, extra_filter) range
    let l:saved_ref = "@"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:patter, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' ")
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif
    
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
