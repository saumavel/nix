{
  programs.nixvim = {
	plugins.oil = {
	  enable = true;
	  settings = {
		default_file_explorer = true;
		columns = [
		  "icon"
		];
		skip_confirm_for_simple_edits = true;
		prompt_save_on_select_new_entry = true;
		constrain_cursor = "editable";
		watch_for_changes = true;
		
		view_options = {
		  show_hidden = true;
		};
		
		keymaps = {
		  "g?" = "actions.show_help";
		  "l" = "actions.select";
		  "<Cr>" = "actions.select";
		  "<C-s>" = {
			__raw = ''{ "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" }'';
		  };
		  "<C-v>" = {
			__raw = ''{ "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" }'';
		  };
		  "<C-p>" = "actions.preview";
		  "<C-c>" = "actions.close";
		  "<C-l>" = "actions.refresh";
		  "h" = "actions.parent";
		  "-" = "actions.open_cwd";
		  "~" = "actions.cd";
		  "gs" = "actions.change_sort";
		  "gx" = "actions.open_external";
		  "g." = "actions.toggle_hidden";
		  "g\\" = "actions.toggle_trash";
		  "<leader>ff" = {
			__raw = ''
			  function()
				require("fzf-lua").files({
				  cwd = require("oil").get_current_dir()
				})
			  end
			'';
			mode = "n";
			nowait = true;
			desc = "Find files in the current directory";
		  };
		  "<leader>fj" = {
			__raw = ''
			  function()
				require("fzf-lua").live_grep({
				  cwd = require("oil").get_current_dir()
				})
			  end
			'';
			mode = "n";
			nowait = true;
			desc = "Grep in the current directory";
		  };
		  "zp" = {
			__raw = ''
			  function()
				local oil = require("oil")
				local name = oil.get_cursor_entry().name
				if name:match("%.pdf$") then
				  local path = oil.get_current_dir() .. name
				  vim.fn.jobstart(string.format("~/.local/bin/zathura-nix %s", vim.fn.shellescape(path)))
				end
			  end
			'';
			desc = "Open PDF in Zathura";
		  };
		};
		use_default_keymaps = false;
	  };
	};
  };
}
