# coding:utf-8
require './lib/bot.rb'

oebot = Bot.new()
begin
  oebot.timeline.userstream do |status|

    username = status.user.screen_name
    contents = status.text
    id = status.id

    # リツイート以外を取得
    if !contents.index("RT") then

      # OEbotを呼び出す(他人へのリプを無視)
      if !(/^@\w*/.match(contents))
        oebot.call(username,contents,id)
      end

      # 自分へのリプであれば
      if contents =~ /^@open_esys\s*/ then
        oebot.call(username,contents,id)
        oebot.being(username,contents,id)
        oebot.ping(username,contents,id)
      end

    end

  sleep 2
  end
rescue Interrupt # ctrl + C
exit 1
end
