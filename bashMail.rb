#!/usr/bin/env ruby

require 'net/smtp'

for i in 0..20
  strspam = "echo 'Subject:Oi meu amor "+i.to_s+"\nOi mor ^^' | ssmtp annacdn@hotmail.com"
  #coisa = system "echo 'Subject:Oi meu amor\nOi mor ^^' | ssmtp annacdn@hotmail.com"
  system strspam
  puts "foi #{i.to_s}"
end
puts "foi"

