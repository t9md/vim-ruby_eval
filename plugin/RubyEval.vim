" if exists('g:loaded_RubyEval') || &cp
  " finish
" endif
" let g:loaded_RubyEval = 1

let s:cpo_save = &cpo
set cpo&vim

command! -range RubyEvalPrint  :call RubyEval#print()
command! -range RubyEvalInsert :call RubyEval#insert()
command! -range RubyEvalReset  :call RubyEval#reset()

let &cpo = s:cpo_save
