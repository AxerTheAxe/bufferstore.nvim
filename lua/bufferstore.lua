local config = require("bufferstore.config")

local M = {}

function M.setup(user_options)
  config.merge_options(user_options or {})
end

return M
