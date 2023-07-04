#!/usr/bin/env ruby
File.foreach('text_messages.log') do |line|
  sender = line[/from:(\S+)/, 1]
  receiver = line[/to:(\S+)/, 1]
  flags = line[/flags:(\S+)/, 1]
  puts "#{sender},#{receiver},#{flags}"
end
