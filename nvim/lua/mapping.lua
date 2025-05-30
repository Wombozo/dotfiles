local registers = {}

local function setup_whichkey()
  if require'plugins'.is_active('whichkeys') then
    require'which-key'.setup(
    require'which-key'.register(registers)
    )
  end
end

local function add_to_whichkey(sc, cmd, desc)
    registers = {[sc] = {cmd, desc}}
end

-- wk.register({
--   ["<leader>f"] = { name = "+file" },
--   ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
--   ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
--   ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
-- })

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  add_to_whichkey(lhs, rhs, "")
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function map_if_active(_p, mode, sc, cmd)
    local typeof=type(_p)
    local plugin=_p
    if typeof=='string' then
        if require'plugins'.is_active(plugin) then
            if mode == 'n' then
                add_to_whichkey(sc,cmd,"")
            end
            return vim.api.nvim_set_keymap(mode, sc, cmd, {})
        end
    elseif typeof=='table' then
        local plugins=_p
        for _,value in ipairs(plugins) do
            if not(require'plugins'.is_active(value)) then
                return
            end
        end
        if mode == 'n' then
            add_to_whichkey(sc,cmd,"")
        end
        return vim.api.nvim_set_keymap(mode, sc, cmd, {})
    end
end

local function map_if_inactive(_p, mode, sc, cmd)
    local typeof=type(_p)
    local plugin=_p
    if typeof=='string' then
        if  not(require'plugins'.is_active(plugin)) then
            if mode == 'n' then
                add_to_whichkey(sc,cmd,"")
            end
            return vim.api.nvim_set_keymap(mode, sc, cmd, {})
        end
    elseif typeof=='table' then
        local plugins=_p
        for _,value in ipairs(plugins) do
            if not(require'plugins'.is_active(value)) then
                if mode == 'n' then
                    add_to_whichkey(sc,cmd,"")
                end
                return vim.api.nvim_set_keymap(mode, sc, cmd, {})
            end
        end
    end
end

-- General -----------------------
map('n', '<C-q>', '<cmd>q<CR>')
-- map('n', '<leader>dd', '<cmd>bdelete<CR>')
map('n', '<leader>o', 'o<C-c>k')
map('n', '<Esc>', '<Esc><cmd>noh<CR>')
map('n', '<leader>pwd', '<cmd>pwd<CR>')
map('n', '<C-0>', '<cmd>e<CR>G')
-- map('n', '<leader>ls', '<cmd>ls<CR>')
map('n', '<leader>tn', '<cmd>tabnew<CR>')
map('n', '<leader>td', '<cmd>tabclose<CR>')
-- map('n', '<C-u>', '<C-u>zz')
-- map('n', '<C-d>', '<C-d>zz')
--- Easier buffer pick
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('t', '<C-h>', [[<C-\><C-n><C-W>h]])
map('t', '<C-l>', [[<C-\><C-n><C-W>l]])
map('t', '<C-j>', [[<C-\><C-n><C-W>j]])
map('t', '<C-k>', [[<C-\><C-n><C-W>k]])
--- Cleaning
map('n', '<BS>', '<cmd>noh | set cmdheight=1<CR>')
---- Saving
map('n', '<C-s>', '<cmd>w<CR>')
map('i', '<C-s>', '<C-c><cmd>w<CR>')
---- Better Escape
map('t','jk', '<C-\\><C-n>')
---- Hidden characters
map('n', '<C-t>', '<cmd>set list!<CR>')
---- Splitting
map('n', '<C-w>s', '<cmd>split<CR>')
map('n', '<C-w>v', '<cmd>vsplit<CR>')
---- Resize split faster
map('n', '<C-w>>', '<cmd>vertical resize +10<CR>')
map('n', '<C-w><', '<cmd>vertical resize -10<CR>')
map('n', '<C-w>.', '<cmd>horizontal resize +10<CR>')
map('n', '<C-w>,', '<cmd>horizontal resize -10<CR>')
---- Save selection to clipboard
map('v', '<leader>c', '"+y')
---- Move text up and down
map('n', '<C-PageDown>', '<cmd>m .+1<CR>==')
map('n', '<C-PageUp>', '<cmd>m .-2<CR>==')
map('v', '<C-PageDown>', '<cmd>m .+1<CR>==')
map('v', '<C-PageUp>', '<cmd>m .-2<CR>==')
map('x', '<C-PageDown>', "<cmd>move '>+1<CR>gv-gv")
map('x', '<C-PageUp>', "<cmd>move '<-2<CR>gv-gv")
---- Indenting
map('v', '<', '<gv')
map('v', '>', '>gv')
---- Delete without saving in visual
-- map('v', 'p', '"_dP')
---- Fold
map('n', 'zd', '<cmd>set nofoldenable<CR>')
map('n', 'ze', '<cmd>set foldenable<CR>')

-- Session -----------------------
-- map_if_active('persistence', 'n', '<leader>ss', "<cmd>lua require('persistence').load()<CR>")
-- map_if_active('persistence', 'n', '<leader>ss', "<cmd>SessionLoad<CR>")
map_if_active('persistence', 'n', '<leader>ss', '<cmd>cd $HOME | SessionSave<CR>')
map_if_active('persistence', 'n', '<leader>sq', ':if len(filter(getbufinfo(), "v:val.changed == 1")) == 0 | call delete("/tmp/nvim_session_lock") | qall | else | echoerr "At least one buffer is modified !"<CR>')

-- Vista -------------------------
map_if_active('vista', 'n','<C-a>', '<cmd>Vista!! <CR>')
map_if_active('symbols-outline', 'n','<C-a>', '<cmd>SymbolsOutline<CR>')

-- Term --------------------------
map('n', '<leader>tt', '<cmd>lua TermToggle()<CR>')
map('n', '<leader>tg', '<cmd>lua GitToggle()<CR>')

-- Fugitive ---------------------
map_if_active('git', 'n', '<leader>gg', '<cmd>Git<CR>')
map_if_active('git', 'n', '<leader>gv', '<cmd>GV --all<CR>')
map_if_active('git', 'n', '<leader>gl', '<cmd>Gclog<CR>')
map_if_active('git', 'n', '<leader>gd', '<cmd>Gdiff<CR>')
-- map_if_active('git', 'n', ']h', '<cmd>GitGutterNextHunk<CR>')
-- map_if_active('git', 'n', '[h', '<cmd>GitGutterPrevHunk<CR>')
map_if_active('git', 'n', '<leader>ge', '<cmd>GitGutterPreviewHunk<CR>')
map_if_active('git', 'n', '<leader>gf', '<cmd>GitGutterFold<CR>')

-- FZF ---------------------------
-- map_if_active('fzf', 'n', '<leader>ff', '<cmd>FZF<CR>')

-- Telescope ---------------------
map_if_active('telescope', 'n', '<C-f>b', '<cmd>Telescope buffers<CR>')
map_if_active('telescope', 'n', '<C-f>i', '<cmd>Telescope git_files<CR>')
map_if_active('telescope', 'n', '<C-f>g', '<cmd>Telescope live_grep<CR>')
map_if_active('telescope', 'n', '<C-f>a', '<cmd>Telescope find_files<CR>')
map_if_active('telescope', 'n', '<C-f>f', '<cmd>FZF .<CR>')
map_if_active('telescope', 'n', '<C-f>o', '<cmd>Telescope oldfiles<CR>')
map_if_active('telescope', 'n', '<C-f>;', "<cmd>lua require('telescope').extensions.neoclip.neoclip()<CR>")
map_if_active('telescope', 'n', '<C-f>\'', '<cmd>Telescope marks<CR>')
map_if_active('telescope', 'n', '<C-f>?', '<cmd>Telescope keymaps<CR>')
map_if_active('telescope', 'n', '<C-f>c', '<cmd>Telescope colorscheme<CR>')
map_if_active({'telescope','wrun', 'zoxide'}, 'n', '<leader>cd', '<cmd>Telescope zoxide list<CR>')

-- Tree ----------------------
map_if_active('nvimtree', 'n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
map_if_active('neotree', 'n', '<C-n>', '<cmd>NeoTreeFocusToggle<CR>')

-- Comments -----------------------
map_if_active('comment', 'n', '<leader>z', ':CommentToggle <CR>')
map_if_active('comment', 'v', '<leader>z', ':CommentToggle <CR>')

-- Bufferline --------------------------
map_if_active('bufferline', 'n', '<TAB>', '<cmd>BufferLineCycleNext<CR>')
map_if_active('bufferline', 'n', '<S-TAB>', '<cmd>BufferLineCyclePrev<CR>')
map_if_inactive('bufferline', 'n', '<TAB>', '<cmd>bnext<CR>')
map_if_inactive('bufferline', 'n', '<S-TAB>', '<cmd>bprevious<CR>')
map_if_active('bufferline', 'n', '<C-b>h', '<cmd>BufferLineMovePrev<CR>')
map_if_active('bufferline', 'n', '<C-b>l', '<cmd>BufferLineMoveNext<CR>')
map_if_active('bufferline', 'n', '<C-b>c', '<cmd>bdelete<CR>')
map_if_active('bufferline', 'n', '<C-b>p', '<cmd>BufferLinePick<CR>')
map_if_active('bufferline', 'n', '<C-b>s', '<cmd>BufferLineSortByDirectory<CR>')
-- map_if_active('bufferline', 'n', '<C-b>tn', '<cmd>tabnew %<CR>')
-- map_if_active('bufferline', 'n', '<C-b>tc', '<cmd>tabclose<CR>')

-- Trouble -----------------------------
map('n', '<leader>st', '<cmd>TroubleToggle<CR>')

-- WRun --------------------------
map_if_active('wrun', 'n', '<leader>we', '<cmd>WRedit<CR>')
map_if_active('wrun', 'n', '<leader>wr', '<cmd>WRrun<CR>')
map_if_active('wrun', 'v', '<leader>wr', '<cmd>WRrun<CR>')
map_if_active('wrun', 'x', '<leader>wr', '<cmd>WRrun<CR>')
map_if_active({'wrun','telescope'}, 'n', '<leader>wi', '<cmd>Telescope zoxide list<CR>')

-- EDevice ----------------------
-- map('n', '<leader>l', '<cmdset autoread | au CursorHold * checktime | call feedkeys("lh")<CR>')

setup_whichkey()
