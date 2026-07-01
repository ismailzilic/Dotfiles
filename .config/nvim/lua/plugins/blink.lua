return {
  	"saghen/blink.cmp",
  	dependencies = { "saghen/blink.lib" },
  	build = function ()
  		require("blink.cmp").build():pwait()
  	end,
  	opts = {
  		fuzzy = { implementation = "rust" },
    		keymap = { preset = "super-tab" },
    		appearance = {
      			nerd_font_variant = "mono",
      			use_nvim_cmp_as_default = true,
    		},
    		sources = {
      			default = { "lsp", "path", "snippets", "buffer" },
    		},
    		completion = {
      			keyword = { range = "full" },
      			documentation = { auto_show = true, auto_show_delay_ms = 400 },
      			menu = {
        			auto_show = true,
        			draw = {
          				treesitter = { "lsp" },
        			},
      			},
    		},
  	},
}
