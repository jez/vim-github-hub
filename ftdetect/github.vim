" GitHub issues and pull requests filetype detection
"
" Maintainer: Jake Zimmerman <jake@zimmerman.io>

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
  let l:hub_filetype = ''
  if expand('%:t') ==# 'PULLREQ_EDITMSG'
    let l:hub_filetype = 'ghpull'
  elseif expand('%:t') ==# 'ISSUE_EDITMSG'
    let l:hub_filetype = 'ghissue'
  elseif expand('%:t') ==# 'RELEASE_EDITMSG'
    let l:hub_filetype = 'ghrelease'
  endif

  if !empty(l:hub_filetype)
    exe 'setlocal filetype='.s:markdown
    exe 'setlocal filetype='.l:hub_filetype
    exe 'setlocal filetype='.s:markdown.'.'.l:hub_filetype
  endif
endfunction

augroup VimGitHubHubFtDetect
  autocmd!
  " github/hub hub sets the filetype to 'gitcommit' with a -c command, which
  " runs after all startup scripts have been run. Therefore, we need to use a
  " FileType autocommand to do it even later than hub.
  autocmd FileType gitcommit call s:overrideHubFiletype()

  " In case they stop doing what they're currently doing at some point
  " (or, in case the user just opens `.git/PULLREQ_EDITMSG` directly)
  autocmd BufRead,BufNewFile *_EDITMSG call s:overrideHubFiletype()
augroup END
