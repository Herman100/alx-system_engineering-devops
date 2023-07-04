#!/usr/bin/env ruby
File.foreach('text_messages.log') do |line|
  match = line.match(/\[from:(?<sender>\S+)\] \[to:(?<receiver>\S+)\] \[flags:(?<flags>\S+)\]/)
  puts "#{match[:sender]},#{match[:receiver]},#{match[:flags]}" if match
end
