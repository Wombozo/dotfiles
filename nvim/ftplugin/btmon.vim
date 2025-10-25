" Vim ftplugin file
" Language: Bluetooth monitor (btmon) logs
" Maintainer: Guillaume
" Latest Revision: 2025-10-17

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Options locales pour les fichiers btmon
setlocal nowrap
setlocal noexpandtab
setlocal tabstop=8
setlocal shiftwidth=8

" Lecture seule par défaut (logs)
setlocal readonly
setlocal nomodifiable

" Folding basé sur les symboles de début de ligne
setlocal foldmethod=expr
setlocal foldexpr=GetBtmonFold(v:lnum)

function! GetBtmonFold(lnum)
  let line = getline(a:lnum)
  if line =~ '^[=@<>]'
    return '>1'
  elseif line =~ '^\s\+' && getline(a:lnum - 1) =~ '^[=@<>]'
    return '1'
  else
    return '1'
  endif
endfunction

" Pas de spell check sur les logs
setlocal nospell

" Commentaires (pour des annotations éventuelles)
setlocal commentstring=#\ %s

let b:undo_ftplugin = "setlocal wrap< expandtab< tabstop< shiftwidth< readonly< modifiable< foldmethod< foldexpr< spell< commentstring<"
