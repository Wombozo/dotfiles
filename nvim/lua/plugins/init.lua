local function packer_startup_func()
  require'packer'.use'wbthomason/packer.nvim'
  for key, value in pairs(require'plugins.plugins'.plugins) do
    if value.active then
      local luafile = 'plugins.' .. key
      for _, use in pairs(require(luafile).use) do
        require'packer'.use(use)
      end
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
