" GitHub issues and pull requests filetype detection
"
" Maintainer: Jake Zimmerman <jake@zimmerman.io>

let s:types = ['pull', 'commit', 'issue', 'release']

let s:pull_filename = 'PULLREQ_EDITMSG'
let s:commit_filename = 'COMMIT_EDITMSG'
let s:issue_filename = 'ISSUE_EDITMSG'
let s:release_filename = 'RELEASE_EDITMSG'

let s:pull_filetype = 'ghpull'
let s:commit_filetype = 'ghcommit'
let s:issue_filetype = 'ghissue'
let s:release_filetype = 'ghrelease'

" I like using vim-pandoc-syntax for Markdown syntax highlighting, so let's
" detect if it's installed and fall back to normal markdown if it's not.
if &runtimepath =~# 'vim-pandoc-syntax'
  let s:markdown = 'pandoc'
else
  let s:markdown = 'markdown'
end

" Override the 'gitcommit' filetype that the hub tool sets with a compound
" markdown + gh(pull|issue) filetype.
function! s:overrideHubFiletype()
  let l:filename = expand('%:t')

  for l:type in s:types
    if l:filename ==# s:{l:type}_filename
      let l:filetype = s:{l:type}_filetype
    endif
  endfor

  if exists('l:filetype')
    execute 'setlocal filetype=' . s:markdown . '.' . l:filetype
  endif
endfunction

augroup VimGitHubHubFtDetect
  autocmd!
  " github/hub hub sets the filetype to 'gitcommit' with a -c command, which
  " runs after all startup scripts have been run. Therefore, we need to use a
  " FileType autocommand to do it even later than hub.
  autocmd FileType gitcommit call s:overrideHubFiletype()

  " In case they stop doing what they're currently doing at some point
  for s:type in s:types
    execute 'autocmd BufRead,BufNewFile ' .
      \ s:{s:type}_filename . ' setlocal filetype=' .
      \ s:markdown . '.' . s:{s:type}_filetype
  endfor
augroup END
