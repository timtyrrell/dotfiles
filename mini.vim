set nocompatible
filetype plugin indent on
syntax on
set hidden

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Plug 'tami5/sqlite.lua'
" Plug 'AckslD/nvim-neoclip.lua'

call plug#end()

lua << EOF

require('telescope').setup {
  defaults = {
    dynamic_preview_title = true,
  }
}

--require("telescope").load_extension("neoclip")
-- require('neoclip').setup({
--   enable_persistant_history = true,
--   history = 20,
-- })

EOF
