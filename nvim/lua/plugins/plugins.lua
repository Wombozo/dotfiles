local M = { }

require'plugins.packer-setup'

local plugins = {
  ['lspconfig'] = {
    active = true,
  },
  ['git'] = {
    active = true,
  },
  ['telescope'] = {
    active = true,
  },
  ['nvimtree'] = {
    active = true,
  },
  ['cmp'] = {
    active = true,
  },
  ['fzf'] = {
    active = true,
  },
  ['dashboard'] = {
    active = false,
  },
  ['alpha'] = {
    active = false,
  },
  ['term'] = {
    active = true,
  },
  ['undotree'] = {
    active = true,
  },
  ['neoclip'] = {
    active = true,
  },
  ['snippets'] = {
    active = true,
  },
  ['lightline'] = {
    active = false,
  },
  ['treesitter'] = {
    active = true,
  },
  ['comment'] = {
    active = true,
  },
  ['vista'] = {
    active = true,
  },
  ['wrun'] = {
    active = true,
  },
  ['marks'] = {
    active = true,
  },
  ['catppuccin'] = {
    active = false,
  },
  ['zoxide'] = {
    active = true,
  },
  ['betterescape'] = {
    active = true,
  },
  ['hipairs'] = {
    active = false,
  },
  ['tabline'] = {
    active = false,
  },
  ['lualine'] = {
    active = true,
  },
  ['bufferline'] = {
    active = true,
  },
  ['barbar'] = {
    active = false,
  },
  ['persistence'] = {
    active = true,
  },
  ['indent-blankline']  = {
    active = true,
  },
  ['scrollview'] = {
    active = true,
  },
  ['glow'] = {
    active = true,
  },
  ['hlslens'] = {
    active = true,
  },
  ['themes'] = {
    active = true,
  },
}

M.get_unused = function()
  for key, value in pairs(plugins) do
    if value.active == false then
      local luafile = 'plugins.' .. key
      print(key .. " :")
      for _, p_use in pairs(require(luafile).use) do
        if type(p_use) == "string" then
          print("\t" .. p_use)
       end
      end
    end
  end
end

M.get_used = function()
  for key, value in pairs(plugins) do
    if value.active == true then
      local luafile = 'plugins.' .. key
      print(key .. " :")
      for _, p_use in pairs(require(luafile).use) do
        if type(p_use) == "string" then
          print("\t" .. p_use)
       end
      end
    end
  end
end

M.get_all = function()
  print("--------------------")
  print("USED :")
  M.get_used()
  print("--------------------")
  print("UNUSED :")
  M.get_unused()
end

M.plugins = plugins

return M
