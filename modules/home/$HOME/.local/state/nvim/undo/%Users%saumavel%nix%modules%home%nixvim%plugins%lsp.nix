Vim�UnDo� C�)�Wdx�a�[	��`���)6�b4��a�R   A                                  gھq    _�                              ����                                                                                                                                                                                                                                                                                                                                       *          V       gھp    �                   �               �              *   {     programs.nixvim = {       plugins = {         lsp = {           enable = true;               keymaps = {             silent = true;             diagnostic = {   %            # Navigate in diagnostics   &            "<leader>k" = "goto_prev";   &            "<leader>j" = "goto_next";             };                 lspBuf = {               gd = "definition";               gD = "references";   #            gt = "type_definition";   "            gi = "implementation";               K = "hover";               "<F2>" = "rename";             };   
        };               servers = {             gopls.enable = true;   )          golangci_lint_ls.enable = true;             lua_ls.enable = true;             nil_ls.enable = true;              pyright.enable = true;             pylsp.enable = true;             tflint.enable = true;             templ.enable = true;             html.enable = true;             htmx.enable = true;   $          tailwindcss.enable = true;              protols.enable = true;   
        };         };       };     };   }5��            *                      �             �                    A                       0
      5��