<<<<<<< HEAD
" --- GENERAL SETTINGS ---
set number              " Show line numbers
set relativenumber      " Show relative line numbers (great for jumping lines)
set cursorline          " Highlight the line the cursor is on
set showcmd             " Show the command in the bottom right
set hlsearch            " Highlight search results
set incsearch           " Search as you type
set ignorecase          " Ignore case when searching...
set smartcase           " ...unless search contains a capital letter
set expandtab           " Use spaces instead of tabs
set shiftwidth=4        " Size of an indent
set softtabstop=4       " Number of spaces that a <Tab> counts for
set tabstop=4           " Number of spaces that a <Tab> counts for
set autoindent          " Copy indent from current line when starting a new line
set laststatus=2        " Always show the status line

" --- VISUALS & COLORS ---
syntax on               " Enable syntax highlighting
set cursorline          " Underline the current line
set termguicolors       " Enable 24-bit RGB colors (works in Windows Terminal)
set background=dark     " Optimize colors for dark backgrounds

" --- STATUS LINE (File name, path, and cursor location) ---
" This creates a custom status bar at the bottom
set statusline=%f\ %y\ %m%r\ %=%l.%c\ %p%%
" Breakdown:
" %f = Full path to file
" %y = File type
" %m = Modified flag [+]
" %r = Read-only flag [RO]
" %= = Right-align the following text
" %l = Current line number
" %c = Current column number
" %p%% = Percentage through the file

" --- FILE TYPE SPECIFIC ---
" Python indentation
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" LaTeX settings
autocmd FileType tex setlocal spell spelllang=en_us

" --- KEYBINDINGS ---
" Press 'jk' quickly to exit Insert mode (faster than Esc)
inoremap jk <Esc>

" Clear search highlighting with <Leader>n
let mapleader = " "
nnoremap <leader>n :nohlsearch<CR>
=======
set number
set relativenumber
>>>>>>> b38e2abfe5c930c5a9d894de488f63e0ae9b0bb0
