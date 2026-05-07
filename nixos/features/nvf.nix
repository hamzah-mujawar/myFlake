{inputs, ...}: {
  flake.nixosModules.neovim = {pkgs, ...}: {
    imports = [inputs.nvf.nixosModules.nvf];

    # dependencies for nvf
    environment.systemPackages = [
      pkgs.marksman
      pkgs.markdownlint-cli2
    ];

    programs.nvf = {
      enable = true;

      settings = {
        vim.utility = {
          smart-splits.enable = true;
          oil-nvim = {
            enable = true;
            gitStatus.enable = true;
          };
        };

        vim.theme = {
          enable = true;
          name = "gruvbox";
          transparent = true;
          style = "dark";
        };

        vim.viAlias = false;

        vim.vimAlias = true;

        vim.lsp = {
          enable = true;
        };

        vim.options = {
          nu = true;
          relativenumber = true;
          expandtab = true;
          smartindent = true;
          tabstop = 4;
          shiftwidth = 4;
          wrap = false;
        };

        vim.startPlugins = [
          "gruvbox"
        ];

        vim.telescope = {
          enable = true;
          extensions = [
            {
              name = "fzf";
              packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
              setup = {
                fzf = {
                  fuzzy = true;
                };
              };
            }
          ];
          mappings.buffers = "fb";
          mappings.diagnostics = "fld";
          mappings.findFiles = "ff";
          mappings.findProjects = "fp";
          mappings.gitBranches = "fvb";
          mappings.gitBufferCommits = "fvcb";
          mappings.gitCommits = "fvcw";
          mappings.gitFiles = "fvf";
          mappings.gitStash = "fvx";
          mappings.gitStatus = "fvs";
          mappings.helpTags = "fh";
          mappings.liveGrep = "fg";
          mappings.lspDefinitions = "flD";
          mappings.lspDocumentSymbols = "flsb";
          mappings.lspReferences = "flr";
          mappings.lspTypeDefinitions = "flt";
          mappings.lspWorkspaceSymbols = "flsw";
          mappings.open = "ft";
          mappings.resume = "fr";
          mappings.treesitter = "fs";
          setupOpts.defaults.color_devicons = true;
        };

        vim.statusline.lualine.enable = true;

        vim.autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          sourcePlugins.ripgrep.enable = true;
          sourcePlugins.spell.enable = true;
        };

        vim.visuals = {
          nvim-web-devicons.enable = true;
          rainbow-delimiters.enable = true;
        };

        vim.formatter = {
          conform-nvim = {
            enable = true;
            setupOpts = {
              format_on_save = {
                lsp_fallback = false;
                timeout_ms = 500;
              };
            };
            setupOpts.formatter_by_ft = {
              nix = [
                "alejandra"
              ];
            };
          };
        };

        vim.languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix = {
            enable = true;
            format.enable = true;
          };

          clang.enable = true;
          markdown.enable = true;

          markdown.extensions.markview-nvim = {
            enable = true;
            setupOpts = {
              preview = {
                icon_provider = "devicons";
              };
            };
          };
        };

        vim.navigation = {
          harpoon = {
            enable = true;
            mappings.file1 = "<C-1>";
            mappings.file2 = "<C-2>";
            mappings.file3 = "<C-3>";
            mappings.file4 = "<C-4>";
          };
        };

        vim.spellcheck = {
          enable = true;
          languages = ["en_gb"];
          ignoredFiletypes = [
            "nix"
            "oil"
            "cpp"
          ];
        };
      };
    };
  };
}
