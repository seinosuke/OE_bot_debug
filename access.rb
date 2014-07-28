# coding:utf-8
require './lib/bot.rb'
require './lib/card.rb'

oebot = Bot.new()
card = Card.new()
list = Array.new()
i = 0

loop do
  begin
    # カードを読むまで諦めない
    num = idnum()
    # members.csv にないIDが読み込まれた場合guest(数字)と表示される
    if card.hash(num).nil? then
      card.reload_guest(num,"guest(#{i})")
      i += 1
    end
    card.reload # members.csv から
    list << card.hash(num)

    # 重複した人物は退室
    leaver = list.uniq.select{|i| list.index(i) != list.rindex(i)}
    if !(leaver.empty?) then
      list = list - leaver
      oebot.out(list,leaver)
    else
      oebot.in(list,card.hash(num))
    end
    sleep 3
    rescue Interrupt # ctrl + C
      exit 1
  end
end
