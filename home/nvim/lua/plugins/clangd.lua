-- In a file like plugins/lsp.lua or similar
return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig").clangd.setup({
                cmd = {
                    "clangd",
                    "--background-index",
                    "--compile-commands-dir=/Users/saumavel/skolinn/keppnisforritun/ass",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                    "--all-scopes-completion",
                    "--cross-file-rename",
                    "--completion-parse=auto",
                    "--log=error",
                    -- Use the SDK path from your Xcode installation
                    "--isysroot=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk",
                },
                on_attach = function(client, bufnr)
                    -- Optional: Add custom on_attach logic here
                end,
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            })
        end,
    },
}
