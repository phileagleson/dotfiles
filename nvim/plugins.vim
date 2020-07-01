" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

call plug#begin('~/.config/nvim/plugged')

" === Editing Plugins === "
" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
" Intellisense Engine
 Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tmux/Neovim movement integration
 Plug 'christoomey/vim-tmux-navigator'

" Denite - Fuzzy finding, buffer management
 Plug 'Shougo/denite.nvim'

" Snippet support
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Print function signatures in echo area
Plug 'Shougo/echodoc.vim'

" === Git Plugins === "
" Enable git changes to be shown in sign column
 Plug 'mhinz/vim-signify'
 Plug 'tpope/vim-fugitive'

" === Javascript Plugins === "
" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'

" ReactJS JSX syntax highlighting
Plug 'mxw/vim-jsx'
" Vim Plugin for graphql
Plug 'jparise/vim-graphql'

" Generate JSDoc commands based on function signature
Plug 'heavenshell/vim-jsdoc'

" Autopair brackets
"Plug 'jiangmiao/auto-pairs'

" === Syntax Highlighting === "

" Syntax highlighting for nginx
Plug 'chr4/nginx.vim'

" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" Syntax highlighting for graphql
Plug 'jparise/vim-graphql'

" Improved syntax highlighting and indentation
Plug 'othree/yajs.vim'

" === UI === "
" File explorer
Plug 'scrooloose/nerdtree'

" Colorscheme
Plug 'mhartington/oceanic-next'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

" Customized vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Auto-update ctags - used for js auto-import
"Plug 'ludovicchabant/vim-gutentags'

" JS auto-import
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

" Auto completiong/import for typescript
Plug 'quramy/tsuquyomi'

Plug 'Shougo/vimproc.vim', {'do': 'make'}
"Initialize plugin system
call plug#end()
