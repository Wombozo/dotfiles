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
  ['dashboard'] = {
    active = false,
  },
  ['alpha'] = {
    active = true,
  },
  ['term'] = {
    active = true,
  },
  ['neoclip'] = {
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
    active = true,
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
      print(key)
    end
  end
end

M.get_used = function()
  for key, value in pairs(plugins) do
    if value.active == true then
      print(key)
    end
  end
end

M.get_all = function()
  for key, _ in pairs(plugins) do
    print(key)
  end
end

M.plugins = plugins

return M
