Vim�UnDo� 7�_���1pƑ�
>*=uT�ʈ�V;��ܣ�^   $                                  gڼ!    _�                             ����                                                                                                                                                                                                                                                                                                                                                             gڻ�     �                 }5��                          �                     �                          �                     5�_�                             ����                                                                                                                                                                                                                                                                                                                                                  V        gڼ     �                   �               �                 {     programs.nixvim.autoCmd = [   :    # Vertically center document when entering insert mode       {         event = "InsertEnter";         command = "norm zz";       }       #    # Open help in a vertical split       {         event = "FileType";         pattern = "help";         command = "wincmd L";       }       *    # Enable spellcheck for some filetypes       {         event = "FileType";         pattern = [           "markdown"         ];   .      command = "setlocal spell spelllang=en";       }     ];   }5��                                  �             �                    $                       z      5��