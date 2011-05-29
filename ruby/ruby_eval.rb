# vim: sw=2 ts=2 fdm=marker fdc=3 fdl=0 fdn=2:

require 'rubygems'
require 'pp'
require "ap"

class RubyEval
  class Buffer #{{{
    def vim_cmd(vim_ex_command)
      VIM::command vim_ex_command
    end

    def vim_eval vim_expression
      VIM::evaluate vim_expression
    end

    def puts(msgs)
      Array(msgs).each do |msg|
        print msg
      end
    end

    def normal(normal_vim_command)
      vim_cmd %[exec "normal #{normal_vim_command}"].gsub('<','\<')
    end

    def normal!(normal_vim_command)
      vim_cmd %[exec "normal! #{normal_vim_command}"].gsub('<','\<')
    end

    def [](num)
      Array(num).map do |num|
        $curbuf[num]
      end
    end

    def []=(range , text)
      replace_lines(range, text)
    end

    def overwrite_lines(linum, lines)
      lines.each_with_index do |line, idx|
        $curbuf[linum + idx] = line
      end
    end

    def insert(num, lines)
      Array(lines).each_with_index do |line, idx|
        $curbuf.append(num+idx, line.to_s.chomp)
      end
    end

    def append(num, text)
      $curbuf.append(num, text)
    end

    def _delete(num)
      ret = $curbuf[num]
      $curbuf.delete(num)
      ret
    end

    def delete(range)
      Array(range).reverse.map {|linum| _delete(linum) }
    end

    def current_range
      normal "`<"
      range_beg = current_line 
      normal "`>"
      range_end = current_line 
      range_beg..range_end
    end

    def selected_text(mode='V')
      if mode == 'V'
        return self[current_range]
      elsif mode == 'v'
        normal "`<";  beg_row, beg_col = cursor
          normal "`>";  end_row, end_col = cursor
          lines = self[beg_row..end_row]
        if beg_row == end_row
          len = end_col - beg_col 
          lines[0] = lines[0][beg_col..end_col]
        else
          lines[ 0] = lines[0][beg_col..-1]
          lines[-1] = lines[-1][0..end_col]
        end
        return lines
      end
    end

    def name
      $curbuf.name
    end

    def replace_lines(range, text)
      text = Array(text)
      pad_size = Array(range).size - text.size
      linum = range.first
      if pad_size > 0
        pad_size.times {|n| delete(linum) }
      elsif pad_size < 0
        pad_size.abs.times {|n| append(linum, "") }
      end
      overwrite_lines(linum, text)
    end

    def current_line
      $curbuf.line_number
    end

    def length
      $curbuf.length
    end

    def cursor
      $curwin.cursor
    end

    def cursor=(cursor)
      $curwin.cursor=cursor
    end

    def eval_obj
      @__eval_obj ||= init_eval_obj
      @__eval_obj
    end

    def init_eval_obj
      o = Object.new
      def o.__rubyeval__binding
        @__rubyeval__binding ||= binding
      end
      o
    end

    def reset!
      @__eval_obj = nil
    end

    def result(meth)
      fmt = case meth
            when 'pp' then :pretty_inspect
            when 'ap' then :ai
            when 'p'  then :inspect
            else
            end
      __code = selected_text('v').join("\n")
      ret = eval_obj.instance_eval {
        eval(__code , __rubyeval__binding )
      }
      ret.send(fmt)
    end
  end #}}}

  class << self
    def buffer
      @b ||= Buffer.new
    end

    def reset!
      buffer.reset!
    end

    def insert_ruby_eval(mode='p')
      buffer.instance_eval {
        insert(current_range.last, result(mode) )
      }
    end

    def print_ruby_eval()
      buffer.instance_eval {
        puts result('ap')
      }
    end
  end
end
