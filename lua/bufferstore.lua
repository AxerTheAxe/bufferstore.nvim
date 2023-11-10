local config = require("bufferstore.config")

local M = {}

---@diagnostic disable: param-type-mismatch
function M.setup(user_options)
  config.merge_options(user_options or {})

  -- Reload desired modules
  package.loaded["bufferstore.cursor_position"] = nil
  pcall(vim.cmd, "autocmd! bs_cursor_position")
  if config.get_option("cursor_position.enabled") then
    require("bufferstore.cursor_position")
  end
end

return M
