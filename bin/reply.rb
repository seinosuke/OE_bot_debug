#!/usr/bin/env ruby
# coding:utf-8

require '../lib/function/function.rb'

oebot = Bot.new(mention:true)
function = Function.new

debug = false
OptionParser.new do |opt|
  opt.on('-d', '--debug','Switch to debug mode'){|v| debug = v}
  opt.parse!(ARGV)
end

system("clear")
puts "debug mode" if debug
puts "ready!"

begin
  oebot.timeline.userstream do |status|

    twitter_id = status.user.screen_name
    contents = status.text
    status_id = status.id

    not_RT = status.retweeted_status.nil?
    isMention = status.user_mentions.any? { |user| user.screen_name == "rei_debug" }
    isReply = /^@\w*/.match(contents)

    # リツイート以外を取得
    if not_RT

      # OEbotを呼び出す(他人へのリプを無視)
      if !isReply
        if contents =~ /(oe|おーいー)(_||\s)(bot|ボット|ﾎﾞｯﾄ|ぼっと)/i
          rep_text = function.call(contents)
          oebot.post(rep_text,twitter_id:twitter_id,status_id:status_id,debug:debug) if rep_text
          oebot.fav(status_id:status_id)
        end
      end

      # 自分へのリプであれば
      if isMention
        rep_text = Function.generate_reply(contents,oebot.config,twitter_id:twitter_id,debug:debug)
        oebot.post(rep_text,twitter_id:twitter_id,status_id:status_id,debug:debug) if rep_text
      end

    end

  sleep 2
  end

rescue => em
  puts Time.now
  p em
  sleep 1800
  retry

rescue Interrupt
  exit 1
end
