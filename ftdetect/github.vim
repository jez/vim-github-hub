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
  if expand('%:t') ==# 'PULLREQ_EDITMSG'
    exe 'setlocal filetype=' .s:markdown .'.ghpull'
  elseif expand('%:t') ==# 'ISSUE_EDITMSG'
    exe 'setlocal filetype=' .s:markdown .'.ghissue'
  elseif expand('%:t') ==# 'RELEASE_EDITMSG'
    exe 'setlocal filetype=' .s:markdown .'.ghrelease'
  endif
endfunction

augroup VimGitHubHubFtDetect
  autocmd!
  " github/hub hub sets the filetype to 'gitcommit' with a -c command, which
  " runs after all startup scripts have been run. Therefore, we need to use a
  " FileType autocommand to do it even later than hub.
  autocmd FileType gitcommit call s:overrideHubFiletype()

  " In case they stop doing what they're currently doing at some point
  exe 'autocmd BufRead,BufNewFile PULLREQ_EDITMSG setlocal filetype='.s:markdown.'.ghpull'
  exe 'autocmd BufRead,BufNewFile ISSUE_EDITMSG setlocal filetype='.s:markdown.'.ghissue'
  exe 'autocmd BufRead,BufNewFile RELEASE_EDITMSG setlocal filetype='.s:markdown.'.ghrelease'
augroup END
