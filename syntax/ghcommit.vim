runtime syntax/ghhub.vim

unlet b:current_syntax

syntax include @gitcommit syntax/gitcommit.vim
syntax region gitcommit start=/\%(^diff --\%(git\|cc\|combined\) \)\@=/ end=/^\%(diff --\|$\|#\)\@=/ fold contains=@gitcommit
