# coding:utf-8
require '../lib/bot.rb'
require '../lib/card.rb'

oebot = Bot.new()
card = Card.new()
list = Array.new()
i = 0
input = ""

loop do
  begin
    print "ฅ(๑'Δ'๑) あなたは既に登録されてますか(y/n)? :"
    input = gets.to_s.chomp

    if input == "y" || input == "Y" then
      puts "ฅ(๑'Δ'๑) カードを置いてください。"
      # カードを読むまで諦めない
      num = Card.idnum()
      # members.csv にないIDが読み込まれた場合guest(数字)と表示される
      if card.hash(num).nil? then
        card.reload_guest(num,"guest(#{i})")
        i += 1
      end
      card.reload # members.csv から
      list << card.hash(num)
      # 重複した人物は退室
      leaver = list.uniq.select{|i| list.index(i) != list.rindex(i)}
      time = Time.now.strftime("[%Y-%m-%d %H:%M]")
      if !(leaver.empty?) then
        list = list - leaver
        text = oebot.function.out(list,leaver,time)
        oebot.post(text,nil,nil)
      else
        text = oebot.function.in(list,card.hash(num),time)
        oebot.post(text,nil,nil)
      end
      sleep 3

    elsif input == "n" || input == "N" then
      print "ฅ(๑'Δ'๑) 名前を入力してください："
      name = gets.chomp!.to_s
      puts "ฅ(๑'Δ'๑) カードを置いてください"
      id_num = Card.idnum()
      file_name = "../list/members.csv"
      new_member = "#{id_num},#{name}\n"
      entry = File.open(file_name,"a")
      entry.write(new_member)
      entry.close
      puts "(๑¯Δ¯๑)/ 登録が完了しました!\n\n"
      sleep 3

    else
      puts "(๑¯Δ¯๑)/ もういちど入力してください。\n\n"
      redo
    end
    input = ""

  rescue Interrupt # ctrl + C
    exit 1
  rescue => em
    p em
    sleep 3
    retry
  end
end
