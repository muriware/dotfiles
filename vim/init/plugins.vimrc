" vim-airline
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#scrollbar#enabled = 0

" tmuxline
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
      \ 'a'    : '#S',
      \ 'win'  : '#I #W #F',
      \ 'cwin' : '#I #W #F',
      \ 'x'    : '%v',
      \ 'y'    : '%R',
      \ 'z'    : '#h',
      \ 'options' : {'status-justify' : 'left'}
      \ }

" ack
let g:ackprg = 'ag --vimgrep --nogroup --nocolor --column'
let g:ackhighlight = 1

" nerdtree
let NERDTreeQuitOnOpen=1
let NERDTreeMapOpenInTab='<C-T>'
let NERDTreeAutoDeleteBuffer = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" vim-fugitive
au FileType gitcommit nmap <buffer> U :Git checkout -- <c-r><c-g><cr>

" command-t
let g:CommandTMatchWindowReverse = 1
let g:CommandTWildIgnore=&wildignore . ",*/node_modules"
noremap <F5> :CommandTFlush<CR>

" vim-indent-guides
let g:indent_guides_start_level = 3
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" coc.nvim
let g:coc_disable_transparent_cursor = 1
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-stylelint',
      \ 'coc-prettier',
      \ 'coc-css',
      \ 'coc-cssmodules',
      \ ]

" use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" goto code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" show all diagnostics.
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>

" search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" prettier
let g:prettier#config#single_quote = 'true'

" vim rest
let g:vrc_curl_opts = {
      \ '-sS': '',
      \ '--connect-timeout': 10,
      \ '-i': '',
      \ '--max-time': 60,
      \}
