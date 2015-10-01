#!/usr/bin/env ruby

require 'net/smtp'

for i in 0..1
  strspam = "echo 'Subject:teste\nOi' | ssmtp joe.dfq@gmail.com"
  #coisa = system "echo 'Subject:Oi meu amor\nOi mor ^^' | ssmtp annacdn@hotmail.com"
  system strspam
  puts "foi #{i.to_s}"
end
puts "foi"

