-- Plugin module
local cursorposition = {}

-- Load the main module
local bufferstore = require("bufferstore")
-- Load the global module
local global = require("bufferstore.global")

-- Check if the toggle setting is false...
if not bufferstore.getSetting("cursorPosition.enabled") then
  -- Delete all autocmds in the augroup
  vim.cmd("augroup bsCursorPosition")
  vim.cmd("autocmd!")
  vim.cmd("augroup END")
  
  -- Delete all created buffer variables
  for _, bufNum in ipairs(vim.api.nvim_list_bufs()) do
    if global.getBufVar("curPos", bufNum) then
      vim.api.nvim_buf_del_var(bufNum, "curPos") 
    end
  end

  return -- Exit this module
end

-- Save the cursor position to a buffer variable
function cursorposition.bufLeave()
  local curPos = vim.fn.winsaveview()
  vim.b.curPos = curPos
end

-- Load the cursor position saved as a buffer 
-- variable
function cursorposition.bufEnter()
  if vim.b.curPos then
    vim.fn.winrestview(vim.b.curPos)
  end
end

-- Define augroup
vim.cmd("augroup bsCursorPosition")
-- Clear the augroup
vim.cmd("autocmd!")

-- Execute cursor save logic when leaving a buffer
vim.cmd("autocmd BufLeave * lua require('bufferstore.cursorposition').bufLeave()")
-- Execute cursor load logic when entering a buffer
vim.cmd("autocmd BufEnter * lua require('bufferstore.cursorposition').bufEnter()")

-- End augroup
vim.cmd("augroup END")

-- Exit this module
return cursorposition
