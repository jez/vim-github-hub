try
  runtime syntax/ghhub.vim
catch
  finish
endtry

if exists('b:current_syntax')
  unlet b:current_syntax
endif

syntax include @gitcommit syntax/gitcommit.vim
syntax region gitcommit start=/\%(^diff --\%(git\|cc\|combined\) \)\@=/ end=/^\%(diff --\|$\|#\)\@=/ fold contains=@gitcommit
