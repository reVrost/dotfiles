local M = {}

-- Plugins
M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

M.ui = {
	theme = "gruvchad",
	hl_override = {
		CursorLine = { bg = "#25252f" },
	},
	tabufline = {
		enabled = false,
	},
	changed_themes = {
		aquarium = {
			base_16 = {
				base00 = "#202026",
			},
		},

		gruvchad = {
			base_16 = {
				base00 = "#1e2122",
				base01 = "#2c2f30",
				base02 = "#36393a",
				base03 = "#404344",
				base04 = "#d4be98",
				base05 = "#c0b196",
				base06 = "#c3b499",
				base07 = "#c7b89d",
				base08 = "#EC857F",
				base09 = "#e78a4e",
				base0A = "#e0c080",
				base0B = "#86b17f",
				base0C = "#828282", -- Special character in strings, sometimes brackets
				base0D = "#7daea3",
				base0E = "#d3869b",
				base0F = "#828282", -- Brackets
			},
		},

		oxocarbon = {
			base_30 = {
				white = "#f2f4f8",
				darker_black = "#0f0f0f",
				black = "#161616", --  nvim bg
				black2 = "#202020",
				one_bg = "#2a2a2a", -- real bg of onedark
				one_bg2 = "#343434",
				one_bg3 = "#3c3c3c",
				grey = "#464646",
				grey_fg = "#4c4c4c",
				grey_fg2 = "#555555",
				light_grey = "#5f5f5f",
				red = "#f64191", -- changed
				baby_pink = "#ff7eb6",
				pink = "#be95ff",
				line = "#383747", -- for lines like vertsplit
				green = "#42be65",
				vibrant_green = "#08bdba",
				nord_blue = "#78a9ff",
				blue = "#33b1ff",
				yellow = "#FAE3B0",
				sun = "#ffe9b6",
				purple = "#d0a9e5",
				dark_purple = "#c7a0dc",
				teal = "#B5E8E0",
				orange = "#F8BD96",
				cyan = "#3ddbd9",
				statusline_bg = "#202020",
				lightbg = "#2a2a2a",
				pmenu_bg = "#3ddbd9",
				folder_bg = "#78a9ff",
				lavender = "#c7d1ff",
			},

			base_16 = {
				base00 = "#0f0f0f", -- Darker
				base01 = "#1f1f1f", -- Darker
				base02 = "#2d2d2d", -- Selection
				base03 = "#525252", -- Comments
				base04 = "#dde1e6",
				base05 = "#d0d0d0", -- Normal text
				base06 = "#f1f1f1",
				base07 = "#08bdba",
				base08 = "#3ddbd9", -- Global Variable, field or property
				base09 = "#3ddbd9", -- Number or boolean or nil
				base0A = "#ffe9b6", -- Type
				base0B = "#ae81df", -- Strings
				base0C = "#ff74b8", -- Special character in strings
				base0D = "#ff74b8", -- Function name
				base0E = "#64a3f3", -- Compiler keywords
				base0F = "#828282", -- Brackets
			},
		},
	},
}

return M
