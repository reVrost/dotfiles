local M = {}

-- Plugins
M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

M.ui = {
	theme = "aquarium",
	hl_override = {
		CursorLine = { bg = "#25252f" },
	},
	tabufline = {
		enabled = false,
	},
	theme_toggle = {
		"aquarium",
		"everforest",
	},
	changed_themes = {
		aquarium = {
			base_16 = {
				base00 = "#121220",
			},
		},

		oxocarbon = {
			base_30 = {
				-- green = "#B5E8E0",
			},

			base_16 = {
				base00 = "#0f0f0f", -- Darker
				base01 = "#1f1f1f", -- Darker
				base02 = "#303030", -- Darker
				base03 = "#525252",
				base04 = "#dde1e6",
				base05 = "#f2f4f8",
				base06 = "#ffffff",
				base07 = "#08bdba",
				base08 = "#3ddbd9",
				base09 = "#78a9ff",
				base0A = "#ee5396",
				base0B = "#33b1ff",
				base0C = "#ff7eb6",
				-- base0D = "#42be65",
				base0D = "#3ddbd9",
				base0E = "#be95ff",
				base0F = "#82cfff",
			},
		},
	},
}

return M
