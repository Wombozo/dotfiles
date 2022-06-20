local function packer_startup_func()
  for _, value in pairs(require'plugins.plugins'.plugins) do
    for _, use in pairs(value.use) do
      require'packer'.use(use)
    end
  end
end

for key,value in pairs(require'plugins.plugins'.plugins) do
  if value.active then
    require('packer').startup(packer_startup_func)
    local luafile = 'plugins.' .. key
    pcall(require, luafile)
  end
end
