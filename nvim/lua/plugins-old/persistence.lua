local M = { }

-- local autoload = true
--
-- local allowed_dirs = nil
--
-- local ignored_dirs = nil
--
-- local function allow_dir()
--   if allowed_dirs == nil then
--     return true
--   end
--   return utils.dirs_match(vim.fn.getcwd(), allowed_dirs)
-- end
--
-- local function ignore_dir()
--   local ignored_dirs = ignored_dirs
--
--   if ignored_dirs == nil then
--     return false
--   end
--   return utils.dirs_match(vim.fn.getcwd(), ignored_dirs)
-- end


M.config = function()
  require("persisted").setup({
    save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
    command = "VimLeavePre", -- the autocommand for which the session is saved
    use_git_branch = false, -- create session files based on the branch of the git enabled repository
    autosave = true, -- automatically save session files when exiting Neovim
    autoload = false, -- automatically load the session for the cwd on Neovim startup
    allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
    ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
    before_save = nil, -- function to run before the session is saved to disk
    after_save = nil, -- function to run after the session is saved to disk
    after_source = nil, -- function to run after the session is sourced
    telescope = { -- options for the telescope extension
    before_source = nil, -- function to run before the session is sourced via telescope
    after_source = nil, -- function to run after the session is sourced via telescope
    },
  })
  -- local persistence = require'persistence'
  -- persistence.setup()
  -- if autoload and (allow_dir() and not ignore_dir()) and vim.fn.argc() == 0 then
  --   persistence.load()
  --   vim.cmd[[ edit ]]
  -- end
  -- local augroup_id = vim.api.nvim_create_augroup('PersistenceZZ', {})
  -- vim.api.nvim_create_autocmd(
  --   {
  --     "BufEnter",
  --   },
  --   {
  --     group = augroup_id,
  --     nested = true,
  --     pattern = "*",
  --     callback = function()
  --       persistence.load()
  --     end,
  --   }
  -- )
end

M.use = {
  -- "folke/persistence.nvim",
  "olimorris/persisted.nvim",

}

return M
