local Sticky = require("sticky.sticky")
local M = {}

local function focus_sticky()
  if not _G._sticky_nvim_instance then
    _G._sticky_nvim_instance = Sticky.new()
  end

  local sticky = _G._sticky_nvim_instance

  if not sticky:is_attached() then
    sticky:attach()
  else
    vim.api.nvim_set_current_win(sticky:winid())
  end
end

M.focus_sticky = focus_sticky

return M
