" if &cp || (exists("g:loaded_vikir") && g:loaded_vikir)
	" finish
" endif

" command! ReloadRubyFile :rubyfile %
let s:ruby_eval_root = expand("<sfile>:p:h:h")
let s:ruby_eval_ruby = s:ruby_eval_root . '/ruby/' . 'ruby_eval.rb'
command! -range RubyEvalPrint  :ruby RubyEval.print_ruby_eval
command! -range RubyEvalInsert :ruby RubyEval.insert_ruby_eval('pp')
command! -range RubyEvalReset  :ruby RubyEval.reset!
execute 'rubyfile '. s:ruby_eval_ruby
