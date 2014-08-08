# coding:utf-8

def gacha()
  pans = Array.new
  c = 0
  Random.new(Time.now.to_i)
  open("../list/pan_list.txt").each do |pan|
    pans << pan.to_s
  end
  pan =  pans[rand(pans.size - 1)]
  loop do
    if pan == "カレーパン"
      if rand(10) <= 3
        return pan.chomp
        c = 1
      else
        return pans[rand(pans.size - 1)].chomp
        c = 1
      end
    else
      return pan.chomp
      c = 1
    end
    if c == 1
      break
    end
  end
end