" Filetype detection for Bluetooth monitor (btmon) logs
au BufRead,BufNewFile btmon_* setfiletype btmon
au BufRead,BufNewFile *.btmon setfiletype btmon
