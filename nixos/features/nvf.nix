{ inputs, ... }: {
	flake.nixosModules.neovim = { pkgs, ... }: {		
	  programs.nvf = {
	    enable = true;
	 
	    settings  = {
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
			setup = {fzf = {fuzzy = true;};};                
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
	   };
	};
    };
}
