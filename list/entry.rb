# coding:utf-8
require "../lib/card.rb"

print "名前を入力してください："
name = gets.chomp!.to_s

puts "カードを置いてください"
id_num = idnum()

file_name = "members.csv"
new_member = "#{id_num},#{name}\n"
entry = File.open(file_name,"a")
entry.write(new_member)
entry.close
puts "登録が完了しました"
