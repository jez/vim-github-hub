" GitHub issues and pull requests filetype detection

" github/hub hub sets the filetype to 'gitcommit' with a -c command, which
" runs after all startup scripts have been run. Therefore, we need to use a
" FileType autocommand to do it even later than hub.

function! s:overrideHubFiletype()
  if expand("%:t") ==# "PULLREQ_EDITMSG"
    setlocal filetype=markdown.ghpull
  elseif expand("%:t") ==# "ISSUE_EDITMSG"
    setlocal filetype=markdown.ghissue
  endif
endfunction

augroup VimGitHubHubFtDetect
  autocmd!
  autocmd FileType gitcommit call s:overrideHubFiletype()

  " In case they stop doing what they're currently doing at some point
  autocmd BufRead,BufNewFile PULLREQ_EDITMSG setlocal filetype=markdown.ghpull
  autocmd BufRead,BufNewFile ISSUE_EDITMSG setlocal filetype=markdown.ghissue
augroup END
