---@type ChadrcConfig

local M = {}

M.ui = {
  tabufline = {
    enabled = false,
  },
}

M.base46 = {
  theme = "ashes",
  hl_override = {
    CursorLine = { bg = "#25252f" },
  },
  changed_themes = {
    ghostly = {
      base_16 = {
        -- base00 = "#202026",
      },
    },

    -- ghostly
    everblush = {
      base_30 = {
        white = "#dadada",
        darker_black = "#101010",
        black = "#101010", -- nvim bg
        black2 = "#161616",
        one_bg = "#232323",
        one_bg2 = "#282828",
        one_bg3 = "#343434",
        grey = "#343434",
        -- grey_fg = "#464d50", -- comments
        -- grey_fg2 = "#50575a",
        grey_fg = "#565d60", -- comments
        grey_fg2 = "#60676a",
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
        dark_purple = "#FFCFA8",
        teal = "#FFCFA8",
        orange = "#fcb163",
        cyan = "#fcb163",
        statusline_bg = "#101010",
        lightbg = "#282828",
        lightbg2 = "#343434",
        pmenu_bg = "#FFCFA8",
        folder_bg = "#f48383",
      },
      base_16 = {
        base00 = "#161616",
        base01 = "#161616",
        base02 = "#343434", -- Selection bg
        base03 = "#444444", -- diagnostic dark, codelens
        base04 = "#88DDD2",
        base05 = "#b0b0b0", -- variables, majority of text
        base06 = "#b0b0b0",
        base07 = "#DDDDDD",
        base08 = "#E5E5E5", -- also variables in params
        base09 = "#E5E5E5",
        base0A = "#E5E5E5", -- Identifiers and types
        base0B = "#77bc9a",
        base0C = "#E5E5E5", -- Symbols
        base0D = "#FFCFA8",
        base0E = "#FFCFA8", -- keywords func, const, if
        base0F = "#FFCFA8", -- Brackets, and commas in lua
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
        base0C = "#EAE3B0", -- Special character and highlights in strings, sometimes brackets
        base0D = "#7daea3",
        base0E = "#d3869b",
        base0F = "#e0c080", -- Brackets, and commas in lua
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
