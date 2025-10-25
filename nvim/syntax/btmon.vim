" Vim syntax file
" Language: Bluetooth monitor (btmon) logs
" Maintainer: Guillaume
" Latest Revision: 2025-10-17

if exists("b:current_syntax")
  finish
endif

" Timestamps
syntax match btmonTimestamp /\s\+\d\+\.\d\+$/

" Symbols and direction indicators
syntax match btmonSymbol /^=/
syntax match btmonSymbol /^@/
syntax match btmonSymbol /^</
syntax match btmonSymbol /^>/

" HCI identifiers and packet numbers
syntax match btmonPacketNum /#\d\+/
syntax match btmonHCI /\[hci\d\+\]/

" Event types
syntax match btmonEvent /\(New\|Open\|Close\) Index:/
syntax match btmonEvent /Index Info:/
syntax match btmonEvent /MGMT \(Open\|Close\):/
syntax match btmonEvent /RAW \(Open\|Close\):/
syntax match btmonEvent /HCI Event:/
syntax match btmonEvent /HCI Command:/

" Command and event codes
syntax match btmonCode /(0x[0-9a-f]\+|0x[0-9a-f]\+)/
syntax match btmonCode /(0x[0-9a-f]\+)/

" Status
syntax keyword btmonStatusOk Success contained
syntax keyword btmonStatusError Error Failed Invalid Unknown contained
syntax match btmonStatus /Status: \(Success\|Error\|Failed\|Invalid\|Unknown\)/ contains=btmonStatusOk,btmonStatusError

" Addresses (MAC Bluetooth)
syntax match btmonAddress /\x\x:\x\x:\x\x:\x\x:\x\x:\x\x/
syntax match btmonAddress /(OUI [0-9A-F]\+-[0-9A-F]\+-[0-9A-F]\+)/

" Manufacturers
syntax match btmonManufacturer /Texas Instruments Inc\./
syntax match btmonManufacturer /Manufacturer:.*/

" Version info
syntax match btmonVersion /version \d\+\.\d\+/
syntax match btmonVersion /Bluetooth \d\+\.\d\+/
syntax match btmonVersion /Linux version [0-9.-]+/

" Features and capabilities (indented lists)
syntax match btmonFeature /^\s\+\w.*$/

" Hex data lines
syntax match btmonHexData /^\s\+\(\x\x \)\+/

" ASCII representation (after hex)
syntax match btmonAscii /\s\s\+[[:print:]]\+\s*$/

" Numbers
syntax match btmonNumber /\<\d\+\>/
syntax match btmonHex /0x[0-9a-fA-F]\+/

" Command/process names
syntax match btmonProcess /btmon\|hcitool\|hciconfig/ contained
syntax match btmonProcessLine /@.*\(btmon\|hcitool\|hciconfig\)/ contains=btmonProcess,btmonSymbol

" Special keywords
syntax keyword btmonKeyword privileged plen ncmd ACL MTU SCO LE
syntax keyword btmonKeyword Master Slave Controller Primary UART

" Notes
syntax match btmonNote /^= Note:.*/

" Define highlighting
hi def link btmonTimestamp Comment
hi def link btmonSymbol Special
hi def link btmonPacketNum Identifier
hi def link btmonHCI Identifier
hi def link btmonEvent Statement
hi def link btmonCode Number
hi def link btmonStatusOk String
hi def link btmonStatusError Error
hi def link btmonStatus Type
hi def link btmonAddress Constant
hi def link btmonManufacturer Type
hi def link btmonVersion PreProc
hi def link btmonFeature Comment
hi def link btmonHexData Number
hi def link btmonAscii Comment
hi def link btmonNumber Number
hi def link btmonHex Number
hi def link btmonProcess Function
hi def link btmonKeyword Keyword
hi def link btmonNote Comment

let b:current_syntax = "btmon"
