
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Startup errors!",
		text = awesome.startup_errors
	})
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)

		if in_error then return end

		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Error!",
			text = tostring(err)
		})

		in_error = false
	end)
end

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

local terminal = "alacritty"
local editor = os.getenv("vim") or "nano"
local editor_cmd = terminal .. " -e " .. editor

local modkey = "Mod4"
local altkey = "Mod1"

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top
}

local nordColors = {
	polarNight = { -- Blue
		_1 = "#2E3440",
		_2 = "#3B4252",
		_3 = "#434C5E",
		_4 = "#4C566A"
	},
	snowStorm = { -- White
		_1 = "#D8DEE9",
		_2 = "#E5E9F0",
		_3 = "#ECEFF4",
	},
	frostContrast = {
		_1 = "#8FBCBB", -- green/blue
		_2 = "#88C0D0", -- cyan
		_3 = "#81A1C1", -- purple/blue
		_4 = "#5E81AC" -- blue
	},
	auroraContrast = {
		_1 = "#BF616A", -- red
		_2 = "#D08770", -- orange
		_3 = "#EBCB8B", -- yellow
		_4 = "#A3BE8C", -- green
		_5 = "#B48EAD" -- purple
	},
}

beautiful.font = "JetBrains Mono NF 12"

beautiful.icon_theme = "Papirus"

beautiful.useless_gap = dpi(5)
beautiful.gap_single_client = true

beautiful.border_width = dpi(2)

beautiful.border_focus = nordColors.auroraContrast._4
beautiful.border_normal = nordColors.polarNight._2
beautiful.bg_focus = nordColors.polarNight._4

beautiful.notification_font = "JetBrains Mono NF 10"
naughty.config.defaults.border_width = dpi(2)
naughty.config.defaults.position = "top_middle"
beautiful.notification_border_color = nordColors.auroraContrast._2

beautiful.bg_systray = nordColors.polarNight._1

function customKeyboardLayout()

	local kbl = awful.widget.keyboardlayout()

	kbl.widget.font = "JetBrains Mono NF 14"

	return kbl
end

mykeyboardlayout = customKeyboardLayout()

mytextclock = wibox.widget.textclock("| %d-%m-%Y | %H:%M", 10)

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c) if c == client.focus then c.minimized = true else c:emit_signal("request::activate", "tasklist", {raise = true}) end end),
	awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
	awful.button({}, 4, function() awful.client.focus.byidx(1) end),
	awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

local clientHandler = {}
clientHandler.floatingResizeAmmount = dpi(20)
clientHandler.floatingMoveAmmount = dpi(30)
clientHandler.tilingResizeFactor = 0.05

clientHandler.resize_client = function(c, direction)

	if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
		if direction == "up" then
			c:relative_move(0, 0, 0, -clientHandler.floatingResizeAmmount)
		elseif direction == "down" then
			c:relative_move(0, 0, 0, clientHandler.floatingResizeAmmount)
		elseif direction == "left" then
			c:relative_move(0, 0, -clientHandler.floatingResizeAmmount, 0)
		elseif direction == "right" then
			c:relative_move(0, 0, clientHandler.floatingResizeAmmount, 0)
		end
	else
		if direction == "up" then
			awful.client.incwfact(-clientHandler.tilingResizeFactor)
		elseif direction == "down" then
			awful.client.incwfact(clientHandler.tilingResizeFactor)
		elseif direction == "left" then
			awful.tag.incmwfact(-clientHandler.tilingResizeFactor)
		elseif direction == "right" then
			awful.tag.incmwfact(clientHandler.tilingResizeFactor)
		end
	end
end

clientHandler.move_client_freeFloat = function(c, direction)

	if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
		local workarea = awful.screen.focused().workarea
		if direction == "up" then
			-- c:geometry({nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil})
			c:relative_move(0, -clientHandler.floatingMoveAmmount, 0, 0)
		elseif direction == "down" then
			-- c:geometry({nil, y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil})
			c:relative_move(0, clientHandler.floatingMoveAmmount, 0, 0)
		elseif direction == "left" then
			-- c:geometry({x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil})
			c:relative_move(-clientHandler.floatingMoveAmmount, 0, 0, 0)
		elseif direction == "right" then
			-- c:geometry({x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil, nil})
			c:relative_move(clientHandler.floatingMoveAmmount, 0, 0, 0)
		end
	elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
		if direction == "up" or direction == "left" then
			awful.client.swap.byidx(-1, c)
		elseif direction == "down" or direction == "right" then
			awful.client.swap.byidx(1, c)
		end
	else
		awful.client.swap.bydirection(direction, c, nil)
	end
end

clientHandler.move_client_snapFloat = function(c, direction)

	if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
		local workarea = awful.screen.focused().workarea
		if direction == "up" then
			c:geometry({nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil})
		elseif direction == "down" then
			c:geometry({nil, y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil})
		elseif direction == "left" then
			c:geometry({x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil})
		elseif direction == "right" then
			c:geometry({x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil, nil})
		end
	elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
		if direction == "up" or direction == "left" then
			awful.client.swap.byidx(-1, c)
		elseif direction == "down" or direction == "right" then
			awful.client.swap.byidx(1, c)
		end
	else
		awful.client.swap.bydirection(direction, c, nil)
	end
end

local kbd = {}
kbd.current = "us"
kbd.switch = function()
	if kbd.current == "us" then
		kbd.current = "se"
		awful.spawn.with_shell("setxkbmap se")
	elseif kbd.current == "se" then
		kbd.current = "us"
		awful.spawn.with_shell("setxkbmap us")
	end
end

local systray = wibox.widget.systray()
systray:set_base_size(20)

local tagList = {
	"  ",	-- 1 Code brackets
	"  ",	-- 2 Globe
	"  ",	-- 3 Terminal
	"  ",	-- 4 Message
	"  ",	-- 5 Datebase
	"  ",	-- 6 Smiley with glases
	"  "	-- 7 Tux
}

awful.screen.connect_for_each_screen(function(s)

	awful.tag(tagList, s, awful.layout.layouts[1])

	s.mypromptbox = awful.widget.prompt()

	s.mylayoutbox = awful.widget.layoutbox(s)

	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc( 1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc( 1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)
	))

	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		style   = {
			font = "JetBrains Mono NF 18",
		},
		buttons = taglist_buttons
	}

	s.mytasklist = awful.widget.tasklist {
		screen  = s,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		height = dpi(22),
		border_width = dpi(0),
		bg = nordColors.polarNight._1,
		visible = true
	})

	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			expand = "outside",
			s.mylayoutbox,
			s.mytaglist,
		},
		{ -- Middle widget
			layout = wibox.layout.fixed.horizontal,
			expand = "outside",
			mykeyboardlayout,
			mytextclock,
		},
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			systray,
		},
	}
end)

root.buttons(gears.table.join(
	awful.button({}, 3, function() awful.spawn(terminal) end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

globalkeys = gears.table.join(

	awful.key({ modkey }, "F1", hotkeys_popup.show_help, { description = "Show help", group = "Settings" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "Reload awesome", group = "Settings" }),
	awful.key({ modkey }, "i", function() kbd.switch() end, { description = "Switch keyboard layout", group = "Settings" }),

	awful.key({ modkey }, "j", function() awful.screen.focus_relative( 1) end, { description = "Focus next", group = "Screen" }),
	awful.key({ modkey }, "k", function() awful.screen.focus_relative(-1) end, { description = "Focus previous", group = "Screen" }),

	awful.key({ modkey }, "l", function() awful.spawn.with_shell("lock-screen") end, { description = "Lock screen", group = "Screen" }),

	awful.key({ modkey }, "Down", function() awful.client.focus.global_bydirection("down") if client.focus then client.focus:raise() end end, { description = "focus down", group = "Client" }),
	awful.key({ modkey }, "Up", function() awful.client.focus.global_bydirection("up") if client.focus then client.focus:raise() end end, { description = "focus up", group = "Client" }),
	awful.key({ modkey }, "Left", function() awful.client.focus.global_bydirection("left") if client.focus then client.focus:raise() end end, { description = "focus left", group = "Client" }),
	awful.key({ modkey }, "Right", function() awful.client.focus.global_bydirection("right") if client.focus then client.focus:raise() end end, { description = "focus right", group = "Client" }),

	awful.key({ modkey, "Control" }, "Down", function() clientHandler.resize_client(client.focus, "down") end, { description = "Resize height +", group = "Client" }),
	awful.key({ modkey, "Control" }, "Up", function() clientHandler.resize_client(client.focus, "up") end, { description = "Resize height -", group = "Client" }),
	awful.key({ modkey, "Control" }, "Left", function() clientHandler.resize_client(client.focus, "left") end, { description = "Resize width -", group = "Client" }),
	awful.key({ modkey, "Control" }, "Right", function() clientHandler.resize_client(client.focus, "right") end, { description = "Resize width +", group = "Client" }),

	awful.key({ modkey, "Shift" }, "Down", function() clientHandler.move_client_freeFloat(client.focus, "down") end, { description = "Move down", group = "Client" }),
	awful.key({ modkey, "Shift" }, "Up", function() clientHandler.move_client_freeFloat(client.focus, "up") end, { description = "Move up", group = "Client" }),
	awful.key({ modkey, "Shift" }, "Left", function() clientHandler.move_client_freeFloat(client.focus, "left") end, { description = "Move left", group = "Client" }),
	awful.key({ modkey, "Shift" }, "Right", function() clientHandler.move_client_freeFloat(client.focus, "right") end, { description = "Move right", group = "Client" }),

	awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster( 1, nil, true) end, { description = "Increase the number of master clients", group = "Layout" }),
	awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end, { description = "Decrease the number of master clients", group = "Layout" }),
	awful.key({ modkey }, "Tab", function() awful.layout.inc( 1) end, { description = "Cycle layout", group = "Layout" }),

	awful.key({ modkey }, "Return", function() awful.spawn.with_shell("rofi-run") end, { description = "Prompt", group = "Launcher" }),
	awful.key({ modkey }, "t", function() awful.spawn(terminal) end, { description = "Terminal", group = "Launcher" }),
	awful.key({ modkey, "Control" }, "t", function() awful.spawn(terminal .. " --class customfloat") end, { description = "Terminal (floating)", group = "Launcher" }),
	awful.key({ modkey }, "b", function() awful.spawn.with_shell("bwmenu") end, { description = "Bitwarden", group = "Launcher" }),
	awful.key({ modkey }, "p", function() awful.spawn.with_shell("flameshot gui") end, { description = "Flameshot", group = "Launcher" }),
	awful.key({ modkey }, "e", function() awful.spawn.with_shell("rofimoji") end, { description = "Emojis", group = "Launcher" }),

	awful.key({ modkey, altkey }, "Right", function() awful.tag.viewnext(awful.screen.focused())  end, { description = "Next tag", group = "Tag" }),
	awful.key({ modkey, altkey }, "Left", function() awful.tag.viewprev(awful.screen.focused())  end, { description = "Previous tag", group = "Tag" })
)

clientkeys = gears.table.join(

	awful.key({ modkey }, "f", function(c) c.fullscreen = not c.fullscreen c:raise() end, { description = "Toggle fullscreen", group = "Client" }),
	awful.key({ modkey }, "q", function(c) c:kill() end, { description = "Close", group = "Client" }),
	awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, { description = "Toggle floating", group = "Client" }),
	awful.key({ modkey }, "o", function(c) c:move_to_screen() end, { description = "Move to screen next screen", group = "Client" }),
	awful.key({ modkey, "Shift" }, "t", function(c) c.ontop = not c.ontop end, { description = "Toggle keep on top", group = "Client" })
)

for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,

		awful.key(
			{ modkey }, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then tag:view_only() end
			end,
			{ description = "View tag #"..i, group = "Tag" }
		),

		awful.key(
			{ modkey, "Shift" }, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{ description = "Move focused client to tag #"..i, group = "Tag" }
		),

		awful.key(
			{ modkey, "Control" }, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						awful.tag.viewtoggle(tag)
					end
				end
			end,
			{ description = "Toggle tag #" .. i, group = "Tag" }
		)
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
	awful.button({ modkey }, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) awful.mouse.client.move(c) end),
	awful.button({ modkey }, 3, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) awful.mouse.client.resize(c) end)
)

root.keys(globalkeys)

awful.rules.rules = {
	{
		rule = {},
	  	properties = {
			border_width = beautiful.border_width,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
	 	}
	},
	{
		rule_any = { type = { "normal", "dialog" } },
		properties = { titlebars_enabled = false }
	},
	{
		rule_any = { instance = { "customfloat" } },
		properties = { placement = awful.placement.centered, floating = true }
	}
}

client.connect_signal("manage", function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)

client.connect_signal("request::titlebars", function(c)

	local buttons = gears.table.join(
		awful.button({}, 1, function() c:emit_signal("request::activate", "titlebar", { raise = true }) awful.mouse.client.move(c) end),
		awful.button({}, 3, function() c:emit_signal("request::activate", "titlebar", { raise = true }) awful.mouse.client.resize(c) end)
	)

	awful.titlebar(c) : setup {
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout  = wibox.layout.fixed.horizontal
		},
		{ -- Middle
			{ -- Title
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Autostart on reload
awful.spawn.with_shell("picom --experimental-backends")
awful.spawn.with_shell("nitrogen --restore")