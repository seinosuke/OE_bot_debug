#!/usr/bin/env ruby
# coding:utf-8

require '../lib/bot.rb'

begin
  loop do
    print "\n> @open_esys "
    contents = gets.to_s.chomp
    contents = "@open_esys #{contents}"
    text = Bot::Function.generate_reply(contents)
    puts "> @test #{text}"
  end
rescue => em
  p em
  retry
rescue Interrupt
  exit 1
end