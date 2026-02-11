
{ config, pkgs, ... }:

{

  programs.neovim = {
	enable = true;
    defaultEditor = true;
    vimAlias = true; 
    configure = {
    customLuaRC = ''
        --Settings
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.o.winborder = "rounded"
        vim.g.have_nerdfont = true
        vim.o.cursorline = true
        vim.o.cursorline = true


        -- Plugin enabling
        require "mini.pick".setup()
        require "mason".setup()
        require "oil".setup()
        require "telescope".setup()

        --Keymappings
        vim.g.mapleader = " "
        vim.keymap.set('n', '<leader>w', ':write<CR>')
        vim.keymap.set('n', '<leader>q', ':quit<CR>')
        vim.lsp.enable({ "lua_ls", "tinymist", "nil_ls", "ltex", "prosemd-lsp", "--stdio" })
        
        vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
        vim.keymap.set('n', '<leader>e', ":Oil --float<CR>")
        vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
        vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
        vim.keymap.set('n', '<leader>t', ":Telescope find_files")
      '';

    customRC = ''
     set t_Co=256
            set paste
            setlocal formatoptions=1
            setlocal linebreak
            set thesaurus+=~/Documents/thesaur/mthesaur.txt
            set complete+=s
            set scrolloff=5
            set path+=,**
            colorscheme gruvbox-material
            set ignorecase
            set cursorline
            set smartcase
            set mouse=a
            set nofoldenable
            let g:transparent_enabled = v:true
            set noswapfile
            map <C-g> :Goyo <CR>
            map <C-z> :ZenMode <CR>
            map <C-l> :Limelight!! <CR>
            map <C-p> :TypstWatch <CR>
            map <C-i> :! pdflatex %<CR><CR<>
            map <C-t> :! typst compile %<CR><CR<>
            map <C-s> :! zathura $(echo % \| sed 's/tex$/pdf/') & disown <CR><CR>
            set spell
            set spelllang=en_us 
            set termguicolors
    '';

       packages.myVimPackage = with pkgs.vimPlugins; {start = [
	    vim-nix
            nvim-lspconfig
            telescope-nvim
            harpoon
            mason-nvim
            mini-pick
            limelight-vim
            oil-nvim 
            zen-mode-nvim
            typst-vim 
            nvim-cmp
	    vim-pandoc
	    vim-airline
            vimtex
	    goyo
            gruvbox
            gruvbox-material
            transparent-nvim
            catppuccin-nvim
            rose-pine
            molokai
            everforest
	        ];
         };
      };
    };

}
