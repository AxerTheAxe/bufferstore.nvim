-- Plugin module
local global = {}

-- Returns the existance of the specified 
-- buffer variable
function global.getBufVar(bufVar, bufNum)
  -- Set the buffer number to the current
  -- buffer if no parameter is specified
  if bufNum == "" then
    bufnum = 0
  end

  -- Check if the buffer variable exists
  local exists = pcall(vim.api.nvim_buf_get_var, bufNum, bufVar)

  -- Return the existance of the buffer
  -- variable
  if exists then
    return true
  else
    return false
  end
end


-- Exit this module
return global
