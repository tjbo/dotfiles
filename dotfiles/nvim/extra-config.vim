""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

set encoding=utf-8
"
" disable auto comment insertion
set formatoptions-=cro

" spellcheck settings
set spell
set spelllang=en

" auto completion to be more like zsh
set wildmode=longest,list,full

" remove mode indicator as it's shown in status bar light line
set noshowmode

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vifm Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable netrw
let g:loaded_netrw = 1
let g:loaded_netwPlugin = 1


" vifm
let g:vifm_replace_netrw = 1
let g:vifm_replace_netrw_cmd = "Vifm"
let g:vifm_embed_term = 1
let g:vifm_embed_split = 1
"
" if we want to load a custom vifm file in the future just for
" vim then we could do so here
" let g:vifm_exec_args = ""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow splitright
" make adjusting splits easier
" these don't work for some reason
" noremap <silent> <C-Left> :vertical resize +3<CR>
" noremap <silent> <C-Right> :vertical resize -3<CR>
" noremap <silent> <C-Up> :resize +3<CR>
" noremap <silent> <C-Down> :resize -3<CR>
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" will need to configure a cron job to delete this if it gets too full too
" fast
set backup
  set writebackup
    au BufWritePre * let &backupext = '%' . substitute(expand("%:p:h"), "/" , "%" , "g") . "%" . strftime("%Y.%m.%d.%H.%M.%S")
      au VimLeave * !cp % ~/.local/share/vim/backups/$(echo %:p | sed 's/\(.*\/\)\(.*\)/\2\/\1/g' | sed 's/\//\%/g')$(date +\%Y.\%m.\%d.\%H.\%M.\%S).wq
        set backupdir=~/.local/share/vim/backups/
