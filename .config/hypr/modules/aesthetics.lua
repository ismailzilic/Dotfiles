local workspace_layout = "master"
local allow_screen_tearing = false
local enable_animations = false

local color_active_border = "rgb(ffffff)"
local color_inactive_border = "rgb(000000)"


hl.config({
	general = {
		gaps_in          = 0,
		gaps_out         = 0,

		border_size      = 2,

		col              = {
			active_border   = color_active_border,
			inactive_border = color_inactive_border,
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing    = allow_screen_tearing,

		layout           = workspace_layout,
	},

	decoration = {
		rounding         = 0,
		rounding_power   = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity   = 1.0,
		inactive_opacity = 1.0,

		shadow           = {
			enabled      = true,
			range        = 4,
			render_power = 3,
			color        = 0xee1a1a1a,
		},

		blur             = {
			enabled  = true,
			size     = 3,
			passes   = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = enable_animations,
	},
})


-- LAYOUT SETTINGS
hl.config({
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
})


-- ANIMATIONS
hl.animation({ leaf = "global", enabled = false, speed = 0, bezier = "default" })
