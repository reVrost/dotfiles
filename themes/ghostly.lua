-- Vesper theme by reVrost
local M = {}

M.base_30 = {
	white = "#dadada",
	darker_black = "#101010",
	black = "#101010", -- nvim bg
	black2 = "#161616",
	one_bg = "#232323",
	one_bg2 = "#282828",
	one_bg3 = "#343434",
	grey = "#343434",
	grey_fg = "#464d50",
	grey_fg2 = "#50575a",
	light_grey = "#50575a",
	red = "#FF8080",
	baby_pink = "#f48383",
	pink = "#ee9cdd",
	line = "#22292b", -- for lines like vertsplit
	green = "#77bc9a",
	vibrant_green = "#88DDD2",
	nord_blue = "#88DDD2",
	blue = "#E5E5E5",
	yellow = "#FFC799",
	sun = "#FFCFA8",
	purple = "#FFCFA8",
	dark_purple = "#65737E",
	teal = "#FFCFA8",
	orange = "#fcb163",
	cyan = "#6cbfbf",
	statusline_bg = "#101010",
	lightbg = "#282828",
	lightbg2 = "#343434",
	pmenu_bg = "#FFCFA8",
	folder_bg = "#f48383",
}

M.base_16 = {
	base00 = "#161616",
	base01 = "#161616",
	base02 = "#343434", -- Selection bg
	base03 = "#666666", -- diagnostic dark
	base04 = "#88DDD2",
	base05 = "#A0A0A0", -- variables
	base06 = "#A0A0A0",
	base07 = "#DDDDDD",
	base08 = "#A0A0A0", -- also variables in params
	base09 = "#E5E5E5",
	base0A = "#E5E5E5", -- Identifiers and types
	base0B = "#77bc9a",
	base0C = "#E5E5E5", -- Symbols
	base0D = "#FFCFA8",
	base0E = "#FFCFA8", -- keywords func, const, if
	base0F = "#8b8b8b", -- Brackets, and commas in lua
}

M.polish_hl = {
	luaTSField = { fg = M.base_16.base0D },
	["@tag.delimiter"] = { fg = M.base_30.cyan },
	["@function"] = { fg = M.base_30.orange },
	["@variable.parameter"] = { fg = M.base_16.base0F },
	["@constructor"] = { fg = M.base_16.base0A },
	["@tag.attribute"] = { fg = M.base_30.orange },
}

-- M = require("base46").override_theme(M, "gruvesper")

M.type = "dark"

return M
