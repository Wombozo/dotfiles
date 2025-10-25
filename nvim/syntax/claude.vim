if exists('b:current_syntax')
    finish
endif

syntax case match

" Claude header ASCII art
syntax match claudeHeader /^[▐▛███▜▌▝▜█▘ ]\+$/
syntax match claudeHeaderInfo /^\s*Claude Code v[0-9.]\+$/
syntax match claudeHeaderInfo /^\s*Sonnet [0-9.]\+.*$/

" Slash commands
syntax match claudeCommand /\/[a-z-]\+\>/

" Prompts and continuations
syntax match claudePrompt /^>\s*/
syntax match claudeContinuation /^\s*⎿\s*/

" Bullet points and markers
syntax match claudeBullet /^\s*●/
syntax match claudeCheckmark /✅/
syntax match claudeCross /❌/

" Tool calls and results
syntax match claudeToolName /^\s*●\s*\zs[A-Z][a-zA-Z]\+\ze(/
syntax match claudeToolResult /⎿\s*\zs\(Found\|Read\|Added\|Interrupted\|Search\)\s\+.*$/
syntax match claudeFileCount /\d\+\s\+\(files\?\|lines\?\)/

" File paths (absolute and relative)
syntax match claudePath #\v(/[a-zA-Z0-9_.-]+)+/?#
syntax match claudePath #\v\@[a-zA-Z0-9_.-]+#

" Section headers
syntax match claudeSection /^\s*\u[^:]*:$/
syntax match claudeSection /^\s*\u[^:]*$/

" Code blocks and output markers
syntax region claudeCode start=/^  [a-zA-Z_#]/ end=/^[^ ]/me=s-1
syntax match claudeOutput /^\s*\d\+\./
syntax match claudeOutput /Option\s\+\d\+/

" Special markers
syntax match claudeSpecial /ctrl+o to expand/
syntax match claudeSpecial /What should Claude do instead?/
syntax match claudeSpecial /\(no content\)/

" Numbers and dates
syntax match claudeNumber /\<\d\+\>/
syntax match claudeDate /\d\{4\}-\d\{2\}-\d\{2\}/

" Comments and notes
syntax match claudeNote /Note:/
syntax match claudeNote /IMPORTANT:/
syntax match claudeNote /Avantage:/
syntax match claudeNote /Inconvénient:/
syntax match claudeNote /Recommandation:/

" Technical terms
syntax keyword claudeTech D-Bus bluetoothd mgmt kernel MGMT_OP_ADD_DEVICE HCI
syntax keyword claudeTech StartDiscovery StopDiscovery Device1 Trusted

" Highlights
highlight default link claudeHeader Special
highlight default link claudeHeaderInfo Title
highlight default link claudeCommand Keyword
highlight default link claudePrompt Special
highlight default link claudeContinuation Comment
highlight default link claudeBullet Special
highlight default link claudeCheckmark DiffAdd
highlight default link claudeCross DiffDelete
highlight default link claudeToolName Function
highlight default link claudeToolResult String
highlight default link claudeFileCount Number
highlight default link claudePath Directory
highlight default link claudeSection Title
highlight default link claudeCode PreProc
highlight default link claudeOutput LineNr
highlight default link claudeSpecial SpecialComment
highlight default link claudeNumber Number
highlight default link claudeDate String
highlight default link claudeNote WarningMsg
highlight default link claudeTech Type

let b:current_syntax = 'claude'
