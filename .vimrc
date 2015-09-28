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
	" All of your Plugins must be added before the following line
call vundle#end()


set backspace=2						" enable <BS> for everything
set number							" Show line numbers
set completeopt=longest,menuone		" Autocompletion options
set complete=.,w,b,u,t,i,d			" autocomplete options (:help 'complete')
set hidden							" hide when switching buffers, don't unload
set laststatus=2					" always show status line
set lazyredraw						" don't update screen when executing macros
set mouse=a							" enable mouse in all modes
set noshowmode						" don't show mode, since I'm already using airline
set nowrap							" disable word wrap
set showbreak="+++ "				" String to show with wrap lines
set number							" show line numbers
set showcmd							" show command on last line of screen
set showmatch						" show bracket matches
set spelllang=es					" spell
set spellfile=~/.vim/spell/es.utf-8.add
set textwidth=0						" don't break lines after some maximum width
set ttyfast							" increase chars sent to screen for redrawing
"set ttyscroll=3					" limit lines to scroll to speed up display
set title							" use filename in window title
set wildmenu						" enhanced cmd line completion
set wildchar=<TAB>					" key for line completion
set noerrorbells					" no error sound
set splitright						" Split new buffer at right

" Folding
set foldignore=						" don't ignore anything when folding
set foldlevelstart=99				" no folds closed on open
set foldmethod=marker				" collapse code using markers
set foldnestmax=1					" limit max folds for indent and syntax methods

" Tabs
set autoindent						" copy indent from previous line
set expandtab						" replace tabs with spaces
set shiftwidth=2					" spaces for autoindenting
set smarttab						" <BS> removes shiftwidth worth of spaces
set softtabstop=4					" spaces for editing, e.g. <Tab> or <BS>
set tabstop=2						" spaces for <Tab>

" Searches
set hlsearch						" highlight search results
set incsearch						" search whilst typing
set ignorecase						" case insensitive searching
set smartcase						" override ignorecase if upper case typed
set more							" Stop in list

" Status bar -> Replace with vim-airplane plugin
set laststatus=2					" show ever
set showmode						" show mode
set showcmd							" show cmd
set ruler							" show cursor line number
set shm=atI							" cut large messages

colorscheme madeofcode
syntax on
