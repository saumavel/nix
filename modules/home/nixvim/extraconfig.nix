{
    programs.nixvim = {
    # Use extraConfig which should be available in most versions
    extraConfig = ''
        lua << EOF
        -- Configure diagnostics
        vim.diagnostic.config({
        signs = {
            text = {
            [vim.diagnostic.severity.ERROR] = '󰯈', --'󰚌',  --󰅚 󰯈
            [vim.diagnostic.severity.WARN] = '',  --'󰀪',  --' ', --󰀪 
            [vim.diagnostic.severity.HINT] = '',  --'󱠂 ', --󰌶 
            [vim.diagnostic.severity.INFO] = '',  --' ', 
            },
            numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
            },
        },
        virtual_text = false,
        update_in_insert = false,
        underline = false,
        severity_sort = true,
        float = {
            focusable = true,
            style = 'minimal',
            border = 'rounded',
            source = 'if_many'
        }
        })
        EOF
    '';
    };
}
