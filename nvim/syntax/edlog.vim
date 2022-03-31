" Vim syntax file
" Language: logs from EDEVICE logs
" Maintainer: Guillaume LAVIGNE
" Latest Revision: February 16th 2022

if exists("b:current_syntax")
  finish
endif

syn match ts "^\d\{4}\/\d\{2}\/\d\{1,2}-\d\{2}:\d\{2}:\d\{2}_\d\{1,4}" nextgroup=ps skipwhite
syn match ps "\S\{1,20}" contained nextgroup=fun skipwhite 
syn match fun "\S\{1,100}"  contained nextgroup=sev skipwhite
syn keyword sev ERR DBG INF MSG WRN CRI

syn match hcic "^< HCI Command:.*"
syn match hcie "^> HCI Event:.*\n.*"

syn match bl "bluetoothd\[\d*\]"

syn match db_file "\/var\/lib\/edevice\/hub_db\.db"
syn keyword db_req SQL REQUEST
syn keyword db_op SELECT INSERT DELETE UPDATE nextgroup=db_arg skipwhite
syn match db_arg ".*" contained 

highlight link ts Operator
highlight link ps Label
highlight link fun Function
highlight link sev Error

highlight link hcic Exception
highlight link hcie Exception

highlight link bl Exception

highlight link db_file Statement
highlight link db_req Keyword
highlight link db_op Identifier
highlight link db_arg Identifier

let b:current_syntax = 'edlog'

"
"*Constant       any constant
" String         a string constant: "this is a string"
" Character      a character constant: 'c', '\n'
" Number         a number constant: 234, 0xff
" Boolean        a boolean constant: TRUE, false
" Float          a floating point constant: 2.3e10
"
"*Identifier     any variable name
" Function       function name (also: methods for classes)
"
"*Statement      any statement
" Conditional    if, then, else, endif, switch, etc.
" Repeat         for, do, while, etc.
" Label          case, default, etc.
" Operator       "sizeof", "+", "*", etc.
" Keyword        any other keyword
" Exception      try, catch, throw
"
"*PreProc        generic Preprocessor
" Include        preprocessor #include
" Define         preprocessor #define
" Macro          same as Define
" PreCondit      preprocessor #if, #else, #endif, etc.
"
"*Type           int, long, char, etc.
" StorageClass   static, register, volatile, etc.
" Structure      struct, union, enum, etc.
" Typedef        A typedef
"
"*Special        any special symbol
" SpecialChar    special character in a constant
" Tag            you can use CTRL-] on this
" Delimiter      character that needs attention
" SpecialComment special things inside a comment
" Debug   
