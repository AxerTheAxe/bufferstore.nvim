-- Plugin module
local M = {}

-- Default settings
local defSettings = {
  --- Setting to save the cursor position
  cursorPosition = {
    enabled = false
  },
  -- Setting to save the directory for
  -- buffers with no filename
  noNameDir = {
    enabled = false,

    -- Toggles printing the directory
    -- after running ':NewNoName'
    printcwd = true
  }
}

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
  -- Unload the cursor position module
  package.loaded["bufferstore.cursorposition"] = nil
  -- Load the cursor position module
  require("bufferstore.cursorposition")

  -- Unload the no name module
  package.loaded["bufferstore.nonamedir"] = nil
  -- Load the no name module
  require("bufferstore.nonamedir")
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
