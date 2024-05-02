local wezterm = require("wezterm")

local function getDiscreteGpu()
	local gpus = wezterm.gui.enumerate_gpus()

	for index, gpu in ipairs(gpus) do
		if gpu.device_type == "DiscreteGpu" then
			return gpus[index]
		end
	end

	return nil
end

local config = wezterm.config_builder()

config.color_scheme = "tokyonight_night"
config.window_padding = {
	left = "10px",
	right = "10px",
	top = "10px",
	bottom = "10px",
}

config.initial_cols = 125
config.initial_rows = 33

config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"
config.enable_scroll_bar = false

config.enable_wayland = false

-- opacity
config.window_background_opacity = 1

config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"
-- config.webgpu_preferred_adapter = getDiscreteGpu()
-- config.max_fps = 60

-- config.window_background_opacity = 1

config.font = wezterm.font("JetBrains Mono Nerd Font Mono")
config.font_size = 11.0
config.line_height = 1

return config
