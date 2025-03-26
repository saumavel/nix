return {
    "folke/snacks.nvim",
    event = "VimEnter",
    enabled = true,
    opts = {
        dashboard = {
            enabled = true,
            width = 60,
            row = nil,
            col = nil,
            pane_gap = 4,
            autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
            preset = {
                -- Combined header with ASCII art on both sides
                header = [[

  ,================.  111000010101001110001110101001   _________________  
  |HELLTARI_001001/|  ‡‡‡‡‡ÞgG‡``````````````ül***¯‹  /' ,__________,  '\ 
  |.--------------.|  ü66GÅÆ````***```3l`ü*```ü33‡**  | '            `  | 
  ||[ _    .  _ ]_||  gÆ````````````````````‹¯*`6`‡*  | |  WELCOME   |  | 
  |`--------------'|  Æ``‹```gÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆ````Çü*  | |    TO      |  | 
  ||              ||  Æ``````‹gÆgGgGÆgÅÆÅÆÆÆÆÆ````ül  | |  HEEEELL!  |  | 
  |`------------_-'|  gÆ``````ÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆ``¯Ç*  | |            |  | 
  ||[=====| o  (@) |  ÇÆ````6ÞÆÆÆÆÆÆgGG```````Æ``¯‹*  | `,__________,'  | 
  |`------'/u\ --- |  lÆÇ```````````ÆÆ‹``````ÆÆÆ`Æ`l  |    _______      | 
  |----------------|  üÆ``````‹`ÆÆ``ÆÆÆÆÆÆÆÆÆÆÆÅ`Æ`¯  |<> [___=___](@)<>| 
  | (/)          []|  6gÆ```6ÆÆÆÆÆ```ÆÆÆÆÆÆÆÅÆÆ`ÆÆ`*  ':________________/ 
  |---===--------==|  3‡ÅÇ```¯ÆÆÆ````Æ``ÆgGÅÆÆÆ`Æ``*    (____________)    
  ||||||||||||||||||  3üÇÅÆ```‡ÆÆ‹```ÆÆÆÆÆÆÆÆÆG```*l   ___________/______ 
  ||||||||||||||||||  ü‡‡3Å``````````6`````ÆÆÅÆ`¯*¯*  /''''=========='(@)\
  ||||||||||||HELL||  3l‡üü```‹gÇÞ`GÆgÆÆÆÆ`Ggü``‡l**  |[][][][][][][][][]|
  ||||||||||||||||||  ü6‡ü6l`````*`*ÆÅÆÆ63```ÅÆ```Ç*  |[][][][][][][][][]|
  |================|  3336Å`````````````````‹ÆÆ```ÆÇ  |[][][][][][][][][]|
 .'                `. 110100011101010011101000011110  \------------------/
]],
                keys = {
                    {
                        icon = "󰉋",
                        key = "e",
                        desc = "Open Oil",
                        action = ":lua require('oil').open()",
                    },
                    {
                        icon = "󰈞 ",
                        key = "f",
                        desc = "Find File",
                        action = ":lua Snacks.dashboard.pick('files')",
                    },
                    {
                        icon = "󰈙 ",
                        key = "n",
                        desc = "New File",
                        action = ":ene | startinsert",
                    },
                    {
                        icon = "󰊄",
                        key = "g",
                        desc = "Find Text",
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                    },
                    {
                        icon = "󰋚",
                        key = "r",
                        desc = "Recent Files",
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                    {
                        icon = "󰮗",
                        key = "c",
                        desc = "Config",
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },
                    {
                        icon = "󰒲",
                        key = "l",
                        desc = "Lazy",
                        action = ":Lazy",
                        enabled = package.loaded.lazy ~= nil,
                    },
                    {
                        icon = "󰒲",
                        key = "x",
                        desc = "Lazy Extra",
                        action = ":Lazy extra",
                        enabled = package.loaded.lazy ~= nil,
                    },
                    {
                        icon = "󰗼",
                        key = "q",
                        desc = "Quit",
                        action = ":qa",
                    },
                },
            },
            formats = {
                key = { "%s", align = "center" },
                desc = { "%s", align = "center" },
                icon = { "%s", align = "center" },
            },
            sections = {
                { section = "header", pane = 1 }, -- Combined header with both ASCII arts
                {
                    section = "keys",
                    gap = 1,
                    padding = 1,
                    pane = 1,
                    align = "center",
                    row = 20, -- Position the keys section below the header
                },
                {
                    section = "startup",
                    pane = 1,
                    row = 30, -- Position the startup section below the keys
                },
            },
        },
    },
    config = function(_, opts)
        require("snacks").setup(opts)
    end,
}
