-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Main monitor
hl.monitor({
	output   = "DP-1",
	mode     = "1920x1080@165",
	position = "1280x0",
	scale    = "1",
})

-- Second monitor
hl.monitor({
	output   = "HDMI-A-2",
	mode     = "1280x1024@75",
	position = "0x0",
	scale    = "1",
})

