local M = {}
local th = "aquarium"

-- Plugins
M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

M.ui = {
  theme = th,
  -- hl_override = "custom.highlights",
}

return M
