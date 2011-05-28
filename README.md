What is this
==================================
Evaluate selected text as ruby code then print or insert. 

I love ruby, one of the goodness of ruby is it has several expression to express 
 array or string.
When I write other language such as Python or JavaScript and want to prepare 
array '[ "a", "b", "c", "d" ]'.
You can write `%w(a b c d)` then select text , then execute `:RubyEvalInsert` to 
insert `[ "a", "b", "c", "d" ]` to buffer.


Requirement
==================================
    gem install awesome_print

Example keymap
==================================
    vnoremap <silent> <M-p> :<C-u>RubyEvalPrint<CR>
    vnoremap <silent> <M-i> :<C-u>RubyEvalInsert<CR>
    vnoremap <silent> <Leader>p :<C-u>RubyEvalPrint<CR>
    vnoremap <silent> <Leader>i :<C-u>RubyEvalInsert<CR>
    vnoremap <silent> <C-x>p :<C-u>RubyEvalPrint<CR>
    vnoremap <silent> <C-x>e :<C-u>RubyEvalInsert<CR>

    nnoremap <silent> <M-p> :<C-u>RubyEvalPrint<CR>
    nnoremap <silent> <M-i> :<C-u>RubyEvalInsert<CR>
    nnoremap <silent> <C-x>p :<C-u>RubyEvalPrint<CR>
    nnoremap <silent> <C-x>e :<C-u>RubyEvalInsert<CR>
    nnoremap <silent> <Leader>p :<C-u>RubyEvalPrint<CR>
    nnoremap <silent> <Leader>i :<C-u>RubyEvalInsert<CR>

