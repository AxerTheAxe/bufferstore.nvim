local M = {}

---@diagnostic disable: inject-field
function M.save_cursor()
  vim.b.cursor_position = vim.fn.winsaveview()
end

function M.load_cursor()
  if vim.b.cursor_position then
    vim.fn.winrestview(vim.b.cursor_position)
  end
end

-- Define augroup
vim.cmd [[
  augroup bs_cursor_position
    autocmd!
    autocmd BufLeave * lua require('bufferstore.cursor_position').save_cursor()
    autocmd BufEnter * lua require('bufferstore.cursor_position').load_cursor()
  augroup END
]]

return M
