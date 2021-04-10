" leader shortcut
let mapleader = ","

" file save shortcut
nmap <leader>w :w<CR>

" set list shortcut
nmap <leader>ll :set list!<CR>

" ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" nerdtree
map <leader>f :NERDTreeToggle<CR>
nmap <leader>c :NERDTreeFind<CR>

" vim-fugitive
nmap <leader>gst :Git<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gb :Git blame<CR>
