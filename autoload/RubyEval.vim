" if exists('g:autoloaded_RubyEval') || &cp
  " finish
" endif
" let g:autoloaded_RubyEval = 1

let s:cpo_save = &cpo
set cpo&vim

let s:ruby_eval_root = expand("<sfile>:p:h:h")
let s:ruby_eval_ruby = s:ruby_eval_root . '/ruby/' . 'ruby_eval.rb'
execute 'rubyfile '. s:ruby_eval_ruby

function! RubyEval#print()
  ruby RubyEval.print_ruby_eval
endfunction

function! RubyEval#insert()
  ruby RubyEval.insert_ruby_eval('pp')
endfunction

function! RubyEval#reset()
  ruby RubyEval.reset!
endfunction

let &cpo = s:cpo_save
