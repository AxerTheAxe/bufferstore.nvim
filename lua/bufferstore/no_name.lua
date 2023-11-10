local config = require("bufferstore.config")

local M = {}

function M.create_no_name(directory)
  vim.fn.chdir(directory or "./")
  vim.cmd("enew")

  if config.get_option("no_name.pwd") then
    print(vim.fn.getcwd())
  end
end

---@diagnostic disable: undefined-field, param-type-mismatch, inject-field
function M.load_no_name()
  if vim.b.buffer_directory then
    vim.fn.chdir(vim.b.buffer_directory)
  elseif vim.fn.bufname("%") == "" then
    vim.b.buffer_directory = vim.fn.getcwd()
  end
end

function M.save_no_name()
  if vim.b.buffer_directory and vim.fn.getcwd() ~= vim.b.buffer_directory then
    vim.b.buffer_directory = vim.fn.getcwd()
  end
end

-- Define augroup
vim.cmd [[
  augroup bs_no_name
    autocmd!
    autocmd BufEnter * lua require('bufferstore.no_name').load_no_name()
    autocmd BufLeave * lua require('bufferstore.no_name').save_no_name()
  augroup END
]]

-- Define command to create blank buffers
vim.cmd("command! -nargs=? -complete=dir ENoName lua require('bufferstore.no_name').create_no_name(<f-args>)")

return M
