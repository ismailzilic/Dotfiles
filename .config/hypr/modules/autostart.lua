-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("qs -c noctalia-shell")
	hl.exec_cmd("easyeffects &")
	hl.exec_cmd("dunst")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)
