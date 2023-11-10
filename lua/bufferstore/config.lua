local M = {}

local options = {
  cursor_position = {
    enabled = false
  },
  no_name = {
    enabled = false,
    pwd = true
  }
}

function M.merge_options(new_options)
  options = vim.tbl_deep_extend("force", options, new_options)
end

function M.get_option(option)
  local keys = {}
  -- Regex for '.'
  for key in string.gmatch(option, "[^%.]+") do
    table.insert(keys, key)
  end

  local result = options
  for _, key in pairs(keys) do
    if result == nil then
      return nil
    end
    result = result[key]
  end
  return result
end

return M
