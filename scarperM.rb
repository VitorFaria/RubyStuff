#!/usr/bin/env ruby

require 'nokogiri'
require 'mechanize'
require 'uri'
require 'pry'

agent = Mechanize.new
mfz = agent.get('http://mobileframehangar.com/index.php')

binding.pry

puts mfz.content
