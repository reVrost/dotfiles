local bg = require("core.utils").bg
local fg = require("core.utils").fg

-- Set HL
bg("Search", "#F9CBBE")
bg("IncSearch", "#F9CBBE")

-- Set highlights for nvim-cmp
bg("CmpItemAbbrDeprecated", "NONE")
fg("CmpItemAbbrDeprecated", "#808080")
--" fuzzy
bg("CmpItemAbbrMatch", "NONE")
bg("CmpItemAbbrMatchFuzzy", "NONE")
fg("CmpItemAbbrMatch", "#E95678")
fg("CmpItemAbbrMatchFuzzy", "#E95678")
-- " light blue
bg("CmpItemKindVariable", "NONE")
bg("CmpItemKindInterface", "NONE")
bg("CmpItemKindText", "NONE")
fg("CmpItemKindVariable", "#59E3E3")
fg("CmpItemKindConstant", "#59E3E3")
fg("CmpItemKindStruct", "#59E3E3")
fg("CmpItemKindInterface", "#59E3E3")
fg("CmpItemKindText", "#59E3E3")
-- " Kind
bg("CmpItemKindFunction", "NONE")
bg("CmpItemKindMethod", "NONE")
fg("CmpItemKindFunction", "#EE64AE")
fg("CmpItemKindMethod", "#E9436F")
fg("CmpItemKindSnippet", "#FAB28E")
fg("CmpItemKindModule", "#09F7A0")
-- " front
bg("CmpItemKindKeyword", "NONE")
bg("CmpItemKindProperty", "NONE")
bg("CmpItemKindUnit", "NONE")
fg("CmpItemKindKeyword", "#D4D4D4")
fg("CmpItemKindProperty", "#D4D4D4")
fg("CmpItemKindUnit", "#D4D4D4")
