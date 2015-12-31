set nocompatible              " be iMproved, required
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'

  "Put your non-Plugin stuff after this line
  "Plugin 'Shougo/neocomplete'				" Automatic keyword completion
  "Plugin 'Shougo/unite.vim'					" Find files and buffers using ag
  "Plugin 'Shougo/vimfiler.vim'				" File Explorer :VimFiler
  Plugin 'jlanzarotta/bufexplorer'			" Buffer Explorer :BufExplore
  Plugin 'godlygeek/tabular'					" Text alignment
  "Plugin 'majutsushi/tagbar'					" Display tags in a window
  "Plugin 'scrooloose/syntastic'				" Syntax checking on write
  Plugin 'tpope/vim-fugitive'					" Git wrapper
  Plugin 'tpope/vim-surround'					" Manipulate quotes and brackets
  Plugin 'bling/vim-airline'					" Pretty statusbar
  Plugin 'terryma/vim-multiple-cursors'		" Multiple cursors work
  Plugin 'edkolev/promptline.vim'				" Prompt generator for bash
  Plugin 'StanAngeloff/php.vim'               " updated PHP
  "Plugin 'altercation/vim-colors-solarized.git'	" Solarized theme
  "Plugin 'nathanaelkane/vim-indent-guides.git'	" Show tab/space guides
  Plugin 'Yggdroot/indentLine'
  Plugin 'fatih/vim-go'
  Plugin 'w0ng/vim-hybrid'
  Plugin 'spf13/PIV'
  Plugin 'hail2u/vim-css3-syntax'
  Plugin 'editorconfig/editorconfig-vim'
  Plugin 'tomasr/molokai'
  " All of your Plugins must be added before the following line
call vundle#end()

let g:badwolf_darkgutter=1
let g:badwolf_css_props_highlight=1
let g:badwolf_html_link_underline=1
let g:molokai_original=0
set t_Co=256
colorscheme badwolf

set number                      " Show line numbers
set showcmd                     " show command on last line of screen
set cursorline                  " Underline the line the cursor is on
set wildmenu                    " enhanced cmd line completion
set lazyredraw                  " don't update screen when executing macros
set showmatch                   " show bracket matches
set backspace=2                 " enable <BS> for everything
set completeopt=longest,menuone " Autocompletion options
set complete=.,w,b,u,t,i,d      " autocomplete options (:help 'complete')
set hidden                      " hide when switching buffers, don't unload
set laststatus=2                " always show status line
set noshowmode                  " don't show mode, since I'm already using airline
set nowrap                      " disable word wrap
set showbreak="+++ "            " String to show with wrap lines
set spelllang=en                " spell
set spellfile=~/.vim/spell/en.utf-8.add
set textwidth=0                 " don't break lines after some maximum width
set ttyfast                     " increase chars sent to screen for redrawing
"set ttyscroll=3                " limit lines to scroll to speed up display
set title                       " use filename in window title
set wildchar=<TAB>              " key for line completion
set noerrorbells                " no error sound
set splitright                  " Split new buffer at right

" Folding
set foldenable                  " Enable Folding
set foldignore=                 " don't ignore anything when folding
set foldlevelstart=99           " no folds closed on open
set foldmethod=indent           " collapse code using indents
set foldnestmax=10              " limit max folds for indent and syntax methods

" Tabs
set tabstop=2                   " spaces for <Tab>
set softtabstop=2               " spaces for editing, e.g. <Tab> or <BS>
set expandtab                   " replace tabs with spaces

" Searches
set hlsearch                    " highlight search results
set incsearch                   " search whilst typing
set ignorecase                  " case insensitive searching
set smartcase                   " override ignorecase if upper case typed
set more                        " Stop in list

" Status bar -> Replace with vim-airplane plugin
set laststatus=2                " show ever
set showmode                    " show mode
set showcmd                     " show cmd
set ruler                       " show cursor line number
set shm=atI                     " cut large messages


syntax enable
