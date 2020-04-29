" Vim syntax file
"
" Maintainer: Jake Zimmerman <jake@zimmerman.io

syn case match
syn sync minlines=50

if has('spell')
  syn spell toplevel
endif

" Try to find the current comment character (not perfect)
function! s:getCommentChar()
  let l:line = getline(search('--- >8 ---', 'nw'))
  if strlen(l:line) > 0
    return [l:line[0], 'region']
  endif

  let l:issueMatch = 'Creating issue'
  let l:pullMatch = 'Requesting a pull'
  let l:commitMatch = 'Please enter the commit message'
  let l:releaseMatch = 'Creating release'

  let l:line = getline(search(
    \ '\v(' .
    \ l:issueMatch .
    \ '|' .
    \ l:pullMatch .
    \ '|' .
    \ l:commitMatch .
    \ '|' .
    \ l:releaseMatch .
    \ ')'
    \ , 'nw'))

  if strlen(l:line) > 0
    return [l:line[0], 'line']
  endif

  return ['#', 'line']
endfunction

let [s:commentChar, s:commentKind] = s:getCommentChar()

if s:commentKind ==# 'region'
  exe "syn region ghhubComment start=/^".s:commentChar." ------------------------ >8 ------------------------/ end=/\\%$/"
else
  exe "syn match ghhubComment '" .s:commentChar .".*'"
endif

syn match   ghhubFirstLine '\%^.*' skipnl
syn match   ghhubTitle     '^.\{0,50\}' contained containedin=ghhubFirstLine contains=@Spell

hi def link ghhubComment       Comment
hi def link ghhubTitle         Keyword
