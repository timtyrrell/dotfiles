local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.mapleader = ","

vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use { -- neoclip {{{
        'AckslD/nvim-neoclip.lua',
        requires = {'tami5/sqlite.lua', module = 'sqlite'},
        config = function()
            require('neoclip').setup{
                history = 20,
                enable_persistant_history = true,
            }
        end
    } -- }}}
    use { -- telescope {{{
        'nvim-telescope/telescope.nvim',
        wants = {'popup.nvim', 'plenary.nvim'},
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
        },
        cmd = 'Telescope',
        module = 'telescope',
        config = function()
            require('telescope').setup({
                defaults = {
                    dynamic_preview_title = true,
                },
            })
        end
    }
end)
