-- === Applique background et colorscheme ici, à la toute fin ===
local json_path = os.getenv('HOME') .. '/.config/nvim/plugin/colorscheme.json'
local function apply_theme_for_mode(mode)
  local f = io.open(json_path, "r")
  if not f then return end
  local content = f:read("*a")
  f:close()
  if content == "" then return end
  local data = vim.fn.json_decode(content)
  if data and data[mode] then
    vim.o.background = mode
    vim.cmd('silent! colorscheme ' .. data[mode])
    vim.g.colors_name = data[mode]
  end
end

local env_bg = vim.env.VIM_BACKGROUND
if env_bg == "light" or env_bg == "dark" then
  apply_theme_for_mode(env_bg)
end

vim.defer_fn(function()
  local env_bg = vim.env.VIM_BACKGROUND
  if env_bg == "light" or env_bg == "dark" then
    apply_theme_for_mode(env_bg)
  end
end, 20)

