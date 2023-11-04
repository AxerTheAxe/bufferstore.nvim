-- Plugin module
local nonamedir = {}

-- Load the main module
local bufferstore = require("bufferstore")
-- Load the global module
local global = require("bufferstore.global")

-- Check if the toggle setting is false...
if not bufferstore.getSetting("noNameDir.enabled") then
  -- Delete all autocmds in the augroup
  vim.cmd("augroup bsNoNameDir")
  vim.cmd("autocmd!")
  vim.cmd("augroup END")

  -- Delete the specified command if it is found
  if vim.fn.exists(":NewNoName") == 2 then
    vim.cmd("delcommand NewNoName")
  end

  -- Delete all created buffer variables
  for _, bufNum in ipairs(vim.api.nvim_list_bufs()) do
    if global.getBufVar("bufDir", bufNum) then
      vim.api.nvim_buf_del_var(bufNum, "bufDir")
    end
  end

  return -- Exit this module
end

-- Create a no name file at the specified
-- directory
function nonamedir.newNoName(dir)
  -- If there is an argument...
  if dir ~= "" then
    vim.fn.chdir(dir)
  end

  vim.cmd("enew")

  -- Check if the toggle setting is true...
  if bufferstore.getSetting("noNameDir.printcwd") then
    print(vim.fn.getcwd())
  end
end

-- Load or save the directory of the
-- selected file to a buffer variable
function nonamedir.bufEnter()
  local bufName = vim.fn.bufname("%")

  if vim.b.bufDir then
    vim.fn.chdir(vim.b.bufDir)
  elseif bufName == "" then
    vim.b.bufDir = vim.fn.getcwd()
  end
end

-- Save the directory of the selected
-- no name file to a buffer variable
function nonamedir.bufLeave()
  if vim.b.bufDir and vim.fn.getcwd() ~= vim.b.bufDir then
    vim.b.bufDir = vim.fn.getcwd()
  end
end

-- Define augroup
vim.cmd("augroup bsNoNameDir")
-- Clear the augroup
vim.cmd("autocmd!")

-- Execute no name directory loading/saving logic
-- when entering a buffer
vim.cmd("autocmd BufEnter * lua require('bufferstore.nonamedir').bufEnter()")
-- Execute no name directory savind login when
-- leaving a buffer
vim.cmd("autocmd BufLeave * lua require('bufferstore.nonamedir').bufLeave()")

-- End augroup
vim.cmd("augroup END")

-- Create a command to make new no name files
vim.cmd("command! -nargs=? -complete=dir NewNoName lua require('bufferstore.nonamedir').newNoName(<q-args>)")

-- Exit this module
return nonamedir
