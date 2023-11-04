-- Plugin module
local M = {}

-- Default settings
local defSettings = {}

-- Settings table
local settings = {}

-- Returns the value of an item in the
-- 'settings' table
function M.getSetting(key)
  local keys = {}
  for k in string.gmatch(key, "[^%.]+") do
    table.insert(keys, k)
  end

  local currentTable = settings
  for _, k in ipairs(keys) do
    currentTable = currentTable[k]
    if currentTable == nil then
      return nil
    end
  end

  return currentTable
end

-- Load other plugin modules
local function loadModules()
end

-- Plugin setup with the user's configuration
function M.setup(user_settings)
  -- Merge the settings table with the user's
  -- configuration
  settings = vim.tbl_deep_extend("force", defSettings, user_settings)

  -- Load other plugin modules once the settings
  -- have been merged
  loadModules()
end

-- Exit this module
return M
