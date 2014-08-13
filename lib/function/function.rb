#coding:utf-8
require_relative "./esysPinger.rb"
require_relative "./gacha.rb"
require_relative "./color_code.rb"

class Bot
  class Function

    def Function::judge_keyword(contents)
      function = new
      time = Time.now.strftime("[%Y-%m-%d %H:%M]")
      time_s = Time.now.strftime("%H時%M分%S秒")
      if contents =~ /(おーいー|oe|OE|openesys|OpenEsys|open_esys|Open_Esys)(_||\s)(BOT|Bot|bot|ボット|ﾎﾞｯﾄ|ぼっと)/ then
        return function.call(time)
      elsif contents =~ /(誰か|だれか|誰が|だれが)/ then
        return function.being(time_s)
      elsif contents =~ /(ping|Ping|PING)/ then
        return function.ping(time)
      elsif contents =~ /(計算機室|機室|きしつ)/ then
        return function.esys_pinger(time_s)
      elsif contents =~ /L棟(パン|ぱん)(ガチャ|がちゃ)/ then
        return function.ltou_gacha(time)
      elsif contents =~ /(Ω|オーム)/ then
        return function.color_encode(contents)
      elsif contents =~ /(黒|茶|赤|橙|黄|緑|青|紫|灰|白)/ then
        return function.color_decode(contents)
      elsif contents =~ /(ありがと|あざす)/ then
        return function.thank_1(time)
      elsif contents =~ /(Thank|thank)/ then
        return function.thank_2(time)
      elsif contents =~ /(本当|ほんと|ホント|嘘|ウソ|うそ)/ then
        return function.pack(time)
      else # どのキーワードにも当てはまらなかったら
        return "#{time}現在、私にそのような機能はありません。"
      end
    end

    # OEbotを呼び出す
    def call(time)
      text = "はい\n#{time}"
      return text
    end

    # 現状を尋ねる(@open_esys)
    def being(time_s)
      members = ""
      File.open("../list/be_in.txt") do |io|
        io.each do |line|
          members += line.to_s
        end
      end
      if !(members.empty?) then
        text = "\n#{time}現在、室内には\n#{members}\nがいます。"
        return text
      else
        text = "#{time_s}現在、室内には誰もいません。"
        return text
      end
    end

    # ping(@open_esys)
    def ping(time)
      text = "pong\n#{time}"
      return text
    end

    # esysPinger (@open_esys)
    def esys_pinger(time_s)
      room = PCroom.new(2..91,timeout:5)
      text = "#{time_s}現在、\n機室では#{room.count(:on)}台が稼働中です。"
      return text
    end

    # L棟パンガチャ (@open_esys)
    def ltou_gacha(time)
      gacha = Gacha.new()
      bun = gacha.buns_gacha()
      text = "本日のL棟パンは#{bun}です。\n#{time}"
      return text
    end

    # 抵抗値 -> カラーコード(@open_esys)
    def color_encode(contents)
      contents = contents.gsub(/@open_esys\s/,"")
      contents = contents.gsub(/(Ω|オーム|\s|　)/,"")
      text = c_encode(contents)
      return text
    end

    # カラーコード -> 抵抗値(@open_esys)
    def color_decode(contents)
      contents = contents.gsub(/@open_esys\s/,"")
      contents = contents.gsub(/(\s|　|,|、)/,"")
      text = c_decode(contents)
      return text
    end

    # どういたしまして(@open_esys)
    def thank_1(time)
      text = "どういたしまして\n#{time}"
      return text
    end

    # You’re welcome.(@open_esys)
    def thank_2(time)
      text = "You’re welcome.\n#{time}"
      return text
    end

    # ほんとです(@open_esys)
    def pack(time)
      text = "パックは嘘を申しません。\n#{time}"
      return text
    end

    # 退室
    def out(list,leaver,time)
      text = "#{leaver[0]}が退室しました。\n#{time}"
      members = ""
      list.each{ |member|
        members += (member) + ","
      }
      File.open("../list/be_in.txt",'w'){|line| line = nil}
      File.write("../list/be_in.txt",members.chop)
      return text
    end

    # 入室
    def in(list,newcomer,time)
      text = "#{newcomer}が入室しました。\n#{time}"
      members = ""
      list.each{ |member|
        members += (member) + ","
      }
      File.open("../list/be_in.txt",'w'){|line| line = nil}
      File.write("../list/be_in.txt",members.chop)
      return text
    end

  end
end
