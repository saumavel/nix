{ pkgs, config, lib, ... }:

{
  imports = [
	# Import all plugin files directly (not from subdirectories)
	./oil.nix
	./tree-sitter.nix
	./trouble.nix
	./which-key.nix
	./web-devicons.nix
	# Add other plugin files as needed
  ];

  programs.nixvim.plugins = {
	gitsigns = {
	  enable = true;
	  settings.signs = {
		add.text = "+";
		change.text = "~";
	  };
	};

	transparent.enable = true;
	web-devicons.enable = true;
	nvim-autopairs.enable = true;
	none-ls.enable = true;
	nvim-surround.enable = true;

	trim = {
	  enable = true;
	  settings = {
		highlight = false;
		ft_blocklist = [
		  "checkhealth"
		  "floaterm"
		  "lspinfo"
		  "TelescopePrompt"
		];
	  };
	};
  };
}
