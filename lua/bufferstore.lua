local config = require("bufferstore.config")

local M = {}

---@diagnostic disable: param-type-mismatch
function M.setup(user_options)
  config.merge_options(user_options or {})

  -- Unload modules
  package.loaded["bufferstore.cursor_position"] = nil
  package.loaded["bufferstore.no_name"] = nil

  -- Clean up
  pcall(vim.cmd, "autocmd! bs_cursor_position")
  pcall(vim.cmd, "autocmd! bs_no_name")
  pcall(vim.cmd, "delcommand ENoName")

  -- Load desired modules
  if config.get_option("cursor_position.enabled") then
    require("bufferstore.cursor_position")
  end
  if config.get_option("no_name.enabled") then
    require("bufferstore.no_name")
  end
end

return M
