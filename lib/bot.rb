# coding:utf-8
require 'yaml'
require 'twitter'
require 'tweetstream'
require './lib/esysPinger.rb'

class Bot
  attr_accessor :client, :timeline, :keys

  def initialize()
    @keys = YAML.load_file('./lib/config.yml')
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = @keys["consumer_key"]
      config.consumer_secret = @keys["consumer_secret"]
      config.access_token = @keys["oauth_token"]
      config.access_token_secret = @keys["oauth_token_secret"]
    end

    TweetStream.configure do |config|
      config.consumer_key = @keys["consumer_key"]
      config.consumer_secret = @keys["consumer_secret"]
      config.oauth_token = @keys["oauth_token"]
      config.oauth_token_secret = @keys["oauth_token_secret"]
      config.auth_method = :oauth
    end
    @timeline = TweetStream::Client.new
  end

  # OEbotを呼び出す
  def call(username,contents,id)
    time = Time.now.strftime("%H時%M分%S秒")
    if contents =~ /(おーいー|oe|OE|openesys|OpenEsys|open_esys|Open_Esys)(_||\s)(BOT|Bot|bot|ボット|ﾎﾞｯﾄ|ぼっと)/ then
      text = "@#{username} はい\n#{time}"
      @client.update(text,{:in_reply_to_status_id => id})
      puts text
    end
  end

  # 現状を尋ねる(@open_esys)
  def being(username,contents,id)
    time = Time.now.strftime("%H時%M分%S秒")
    if contents =~ /(誰か|だれか|誰が|だれが)/ then
      members = ""
      File.open("./list/be_in.txt") do |io|
        io.each do |line|
          members += line.to_s
        end
      end
      if !(members.empty?) then
        text = "@#{username} \n#{time}現在、室内には\n#{members}\nがいます。"
        @client.update(text,{:in_reply_to_status_id => id})
        puts text
      else
        text = "@#{username} #{time}現在、室内には誰もいません。"
        @client.update(text,{:in_reply_to_status_id => id})
        puts text
      end
    end
  end

  # esysPinger (@open_esys)
  def esys_pinger(username,contents,id)
    room = PCroom.new(2..91,timeout:5)
    time = Time.now.strftime("%H時%M分%S秒")
    if contents =~ /(計算機室|機室|きしつ)/ then
      text = "@#{username} #{time}現在、\n#{room.count(:on)}台が稼働中です。"
      @client.update(text,{:in_reply_to_status_id => id})
      puts text
    end
  end

  # ping(@open_esys)
  def ping(username,contents,id)
    time = Time.now.strftime("%H時%M分%S秒")
    if contents =~ /(ping|Ping|PING)/ then
      text = "@#{username} pong\n#{time}"
      @client.update(text,{:in_reply_to_status_id => id})
      puts text
    end
  end

  # 退室
  def out(list,leaver)
    time = Time.now.strftime("%H時%M分%S秒")
    text = "#{time}\n#{leaver[0]}が退室しました。"
    @client.update(text)
    puts text
    members = ""
    list.each{ |member|
      members += (member) + ","
    }
    File.open("./list/be_in.txt",'w'){|line| line = nil}
    File.write("./list/be_in.txt",members.chop)
  end

  # 入室
  def in(list,newcomer)
    time = Time.now.strftime("%H時%M分%S秒")
    text = "#{time}\n#{newcomer}が入室しました。"
    @client.update(text)
    puts text
    members = ""
    list.each{ |member|
      members += (member) + ","
    }
    File.open("./list/be_in.txt",'w'){|line| line = nil}
    File.write("./list/be_in.txt",members.chop)
  end
end
