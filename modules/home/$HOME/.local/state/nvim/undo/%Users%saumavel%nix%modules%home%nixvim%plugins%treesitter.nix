Vim�UnDo� �F���q���I���{��q��}5���*�'�   K                                  g��    _�                     8       ����                                                                                                                                                                                                                                                                                                                                                             g�Ԕ     �   8   :   :    5��    8                      \                     �    8                      \                     5�_�                    9        ����                                                                                                                                                                                                                                                                                                                                                             g�Ԗ     �   8   J   ;       �   9   :   ;    5��    8                     \                    5�_�                    9        ����                                                                                                                                                                                                                                                                                                                                                             g�Ԡ     �   8   :   K      1# Explicitly install parsers for common languages5��    8                      \                     5�_�                    :        ����                                                                                                                                                                                                                                                                                                                                                             g�Ԫ     �   J              }�   I   K   K        };�   H   J   K      ];�   G   I   K        "yaml"�   F   H   K        "vim"�   E   G   K        "typescript"�   D   F   K        "rust"�   C   E   K      
  "python"�   B   D   K        "nix"�   A   C   K        "markdown"�   @   B   K        "lua"�   ?   A   K        "json"�   >   @   K        "javascript"�   =   ?   K        "go"�   <   >   K        "cpp"�   ;   =   K        "c"�   :   <   K        "bash"�   9   ;   K      ensure_installed = [5��    9                      �                     �    :                     �                     �    ;                     �                     �    <                     �                     �    =                     �                     �    >                     �                     �    ?                     �                     �    @                     �                     �    A                     	                     �    B                     	                     �    C                     $	                     �    D                     3	                     �    E                     @	                     �    F                     S	                     �    G                     _	                     �    H                      j	                     �    I                     s	                     �    J                      z	                     5�_�                    J       ����                                                                                                                                                                                                                                                                                                                                                             g�Ա     �   H   K   K          ];      };�   I   K   K            };5��    I                      q	                     �    H                     p	                     �    H                   p	                    �    I                     q	                    5�_�                    K       ����                                                                                                                                                                                                                                                                                                                                                             g�Թ    �   J                  }5��    J                      v	                     5�_�                    I       ����                                                                                                                                                                                                                                                                                                                                                             g��     �   I   K   L          �   J   K   L    �   J   K   L    �   I   K   K    5��    I                      q	                     �    I                     u	                     5�_�      	              J       ����                                                                                                                                                                                                                                                                                                                                                             g��%     �   I   K   L           auto_install = true;5��    I                     u	                     5�_�      
           	   9        ����                                                                                                                                                                                                                                                                                                                            9          J          V       g��Q     �   8   9          5    # Explicitly install parsers for common languages       ensure_installed = [         "bash"   	      "c"         "cpp"   
      "go"         "javascript"         "json"         "lua"         "markdown"         "nix"         "python"         "rust"         "typescript"         "vim"         "yaml"       ];       auto_install = true;5��    8                      \      .              5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                            9          9          V       g��^     �         ;              �         :    5��                          �              	       �                          �                     �                         �              	       �                          �                     5�_�   
                         ����                                                                                                                                                                                                                                                                                                                            ;          ;          V       g��`     �         <       �         <    5��                          �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                            ;          ;          V       g��k     �                 auto_install = true;5��                          �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                            :          :          V       g��p     �         <              �         ;    5��                          �              	       �                          �                     �                         �              	       �                          �                     5�_�                            ����                                                                                                                                                                                                                                                                                                                            <          <          V       g��|     �      *   =       �         =    5��                         �                    5�_�                            ����                                                                                                                                                                                                                                                                                                                            L          L          V       g�Չ     �         M      0# This is the correct place for ensure_installed5��                          �                     5�_�                            ����                                                                                                                                                                                                                                                                                                                            L          L          V       g�Փ    �   (   *   M      ];�   '   )   M        "yaml"�   &   (   M        "vim"�   %   '   M        "typescript"�   $   &   M        "rust"�   #   %   M      
  "python"�   "   $   M        "nix"�   !   #   M        "markdown"�       "   M        "lua"�      !   M        "json"�          M        "javascript"�         M        "go"�         M        "cpp"�         M        "c"�         M        "bash"�         M      ensure_installed = [5��                          �                     �                         �                     �                         �                     �                         	                     �                                              �                         (                     �                         ?                     �                          P                     �    !                     `                     �    "                     u                     �    #                     �                     �    $                     �                     �    %                     �                     �    &                     �                     �    '                     �                     �    (                      �                     5�_�                             ����                                                                                                                                                                                                                                                                                                                                       M          V        g��    �                   �               �              M   {     programs.nixvim.plugins = {   @    # Treesitter - Advanced syntax highlighting and code parsing   ]    # Provides more accurate and performant syntax highlighting than regex-based highlighting       treesitter = {         enable = true;       @      # Enable special injections for Nixvim configuration files   T      # This provides better syntax highlighting for Nix code in Nixvim config files         nixvimInjections = true;       0      # Enable code folding based on syntax tree   Y      # Allows folding functions, classes, and other code blocks based on their structure         folding = true;                  settings = {   )        # Enable syntax-aware indentation   B        # Provides better auto-indentation based on code structure           indent.enable = true;              $        # Enable syntax highlighting   ]        # The core feature of Treesitter - provides accurate and colorful syntax highlighting            highlight.enable = true;       8        # This is the correct place for ensure_installed           ensure_installed = [             "bash"             "c"             "cpp"             "go"             "javascript"             "json"             "lua"             "markdown"             "nix"             "python"             "rust"             "typescript"             "vim"             "yaml"   
        ];                  =        # Uncomment to install all available language parsers   J        # This would provide support for all languages Treesitter supports   #        # ensure_installed = "all";              K        # Automatically install parsers when opening files of unknown types   U        # Convenient for automatically supporting new languages as you encounter them           auto_install = true;         };       };       >    # Treesitter Refactor - Code navigation and smart renaming   6    # Extends Treesitter with refactoring capabilities       treesitter-refactor = {         enable = true;            3      # Highlight definition of symbol under cursor   D      # Makes it easier to see where variables/functions are defined         highlightDefinitions = {           enable = true;              3        # Don't clear highlights when moving cursor   A        # Keeps definitions highlighted even when you move around   ;        # Set to false if you have an `updatetime` of ~100.   "        clearOnCursorMove = false;         };       };       ;    # HMTS - HTML, Markdown, and TSX support for Treesitter   F    # Enhances Treesitter's capabilities for web development languages       hmts = {   X      enable = true;  # Enable improved HTML, Markdown, and TSX parsing and highlighting       };     };   }5��            M                      �	             �                    K                       �	      5��