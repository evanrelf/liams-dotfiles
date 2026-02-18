
# NVim on Nix yo, 'tis NixVim

  let
    nixvim = import (builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
    });
  in
  { imports = [nixvim.nixosModules.nixvim];

  programs.nixvim = {
    enable = true;
    colorschemes = {
       gruvbox-material.enable = true;
    };
    globals.mapleader = " ";
    viAlias = true;
    defaultEditor = true;
    vimAlias = true;
    opts = {
      number = true;
      relativenumber = true; 
      winborder = "rounded";
      shiftwidth = 3;
      cursorline = true;
      signcolumn = "yes"; 
      ignorecase = true; 
      termguicolors = true;
      scrolloff = 5;
      smartindent = true;
      swapfile = false;
      linebreak = true;
      spell = true;
      spelllang = "en_us";
      }; 
      
    plugins = {
      lualine.enable = true;
      telescope.enable = true; 
      transparent.enable = true;
      oil.enable = true;
      vimtex.enable = true;
      treesitter.enable = true;
      typst-vim.enable = true;
      lsp.enable = true;
      web-devicons.enable = true;
      zen-mode = {
        enable = true;
        settings = { 
            window = {
              backdrop = 1;
              height = 0.9;
              width = 0.8;
            };
         };
        };
      };

#LSP
    lsp.servers = {
        nixd.enable = true;
        nil_ls.enable = true;
        tinymist.enable = true;
        texlab.enable = true;
        lua_ls.enable = true;
        css_ls.enable = true;
        marksman.enable = true;
      };


    keymaps = [
      { # easy writing
      key = "<Leader>w";
      mode = "n";
      action = ":write<CR>";
      }
      { # easy quitting
      key = "<Leader>q";
      mode = "n";
      action = ":quit<CR>";
      }
      { # Oil
      key = "<Leader>e";
      mode = "n";
      action = ":Oil --float<CR>";
      }
      { # Telescope files
      key = "<Leader>f";
      mode = "n";
      action = ":Telescope find_files<CR>";
      }
      { # Telescope Help
      key = "<Leader>h";
      mode = "n";
      action = ":Telescope help_tags<CR>";
      }
      { # Telescope Buffers
      key = "<Leader>b";
      mode = "n";
      action = ":Telescope buffers<CR>";
      }
      { # Telescope Registers
      key = "<Leader>y";
      mode = "n";
      action = ":Telescope registers<CR>";
      }
      { # Telescope Grep String
      key = "<Leader>ps";
      mode = "n";
      action = ":Telescope grep_string<CR>";
      }
      { # Language Servers
      key = "<Leader>ls";
      mode = "n";
      action = ":LspStart<CR>";
      }
      { # Hover?
      key = "<Leader>lh";
      mode = "n";
      action.__raw = "function() vim.lsp.buf.hover() end, opts";
      }
      { # Hover?
      key = "<Leader>lf";
      mode = "n";
      action.__raw = "function() vim.lsp.buf.format() end, opts";
      }
      { # Autocomplete?
      key = "<C-Space>";
      mode = "i";
      action.__raw = "function() vim.lsp.completion.enable() end, opts";
      }
      { # Zen
      key = "<C-g>";
      mode = "n";
      action = ":ZenMode<CR>";
      }
      { # Limelight
      key = "<C-l>";
      mode = "n";
      action = ":Twilight<CR>";
      }
      { # Typst Watch
      key = "<leader>p";
      mode = "n";
      action = ":TypstWatch <CR>";
      }
      { # LateX Compile
      key = "<C-i>";
      mode = "n";
      action = ":! pdflatex %<CR><CR>";
      }
      { # LateX Preview
      key = "<C-s>";
      mode = "n";
      action = ":! zathura %(echo % \| sed 's/tex$/pdf/') & disown <CR><CR>";
      }
      { # Clipboard with Leader	
      key = "<C-y>";
      mode = "v";
      action = "\"+y";
      }
      { # Clipboard with Leader	
      key = "<C-p>";
      mode = "v";
      action = "\"+p";
      }
      ];
  };

}
