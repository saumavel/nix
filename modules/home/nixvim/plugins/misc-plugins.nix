{
  programs.nixvim.plugins = {

	# Markdown and stuff	
    web-devicons = {
      enable = true;
    };
	markdown-preview = {
	  enable = true;
	  settings = {
		auto_close = 1;
		theme = "dark";
	  };
	};

    comment = {
      enable = true;
    };
	# Language server?
	nix = {
	  enable = true;
	};

	trouble = {
	  enable = true;
	};

	which-key = {
	  enable = true;
	};
	
	indent-o-matic = {
	  enable = true;
}



    harpoon = {
      enable = true;
      keymapsSilent = true;
      keymaps = {
    	addFile = "<leader>a";
    	toggleQuickMenu = "<C-e>";
    	navFile = {
	      "1" = "<C-j>";
	      "2" = "<C-k>";
	      "3" = "<C-l>";
	      "4" = "<C-m>";
    	};
      };
    };

  };
}
