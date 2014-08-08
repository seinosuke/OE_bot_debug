# coding:utf-8
require '../lib/bot.rb'

oebot = Bot.new(true)
begin
  oebot.timeline.userstream do |status|

    username = status.user.screen_name
    contents = status.text
    id = status.id

    # リツイート以外を取得
    if !contents.index("RT") then

      # OEbotを呼び出す(他人へのリプを無視)
      if !(/^@\w*/.match(contents))
        if contents =~ /(おーいー|oe|OE|openesys|OpenEsys|open_esys|Open_Esys)(_||\s)(BOT|Bot|bot|ボット|ﾎﾞｯﾄ|ぼっと)/
          time = Time.now.strftime("%H時%M分%S秒")
          text = oebot.function.call(time)
          oebot.post(text,username,id)
        end
      end

      # 自分へのリプであれば
      if contents =~ /^@open_esys\s*/ then
        text = Bot::Function.judge_keyword(contents)
        oebot.post(text,username,id)
      end

    end

  sleep 2
  end
rescue => em
  puts Time.now
  p em
  sleep 1800
  retry
rescue Interrupt # ctrl + C
  exit 1
end
