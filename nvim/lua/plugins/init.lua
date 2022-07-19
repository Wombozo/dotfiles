local function packer_startup_func()
  require'packer'.use'wbthomason/packer.nvim'
  for key, value in pairs(require'plugins.plugins'.plugins) do
    if value.active then
      local luafile = 'plugins.' .. key
      require'packer'.use(require(luafile).use)
    end
  end
end

require'packer'.startup(packer_startup_func)

for key, value in pairs(require'plugins.plugins'.plugins) do
  if value.active then
    local luafile = 'plugins.' .. key
    require(luafile).config()
  end
end
