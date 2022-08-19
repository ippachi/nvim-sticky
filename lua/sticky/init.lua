local Sticky = require("sticky.sticky")
local M = {}

local function toggle_sticky()
  if not _G._sticky_nvim_instance then
    _G._sticky_nvim_instance = Sticky.new()
  end

  local sticky = _G._sticky_nvim_instance

  if sticky:is_attached() then
    sticky:detach()
  else
    sticky:attach()
  end
end

M.toggle_sticky = toggle_sticky

return M
