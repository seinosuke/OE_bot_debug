#coding:utf-8

# 抵抗値 -> カラーコード(@open_esys)
def c_encode(ohm_s)

  color = {"黒" => 0,"茶" => 1,"赤" => 2,"橙" => 3,"黄" => 4,"緑" => 5,"青" => 6,"紫" => 7,"灰" => 8,"白" => 9}

  ohm = ohm_s.to_f
  if ohm_s =~ /(k|K|キロ)/
    ohm *= 1000
  elsif ohm_s =~ /(m|M|メガ)/
    ohm *= 1000000
  end

  ans = []
  error = false

  digits_num = ohm.to_s.length - 2
  if color.key(digits_num) == nil
    error = true
  end

  if !error then
    if digits_num >2
      ohm = ohm/(10**(digits_num-2))
      ohm = ohm.to_i
      ans[0] = color.key(ohm/10)
      ans[1] = color.key(ohm - (ohm/10)*10)
      ans[2] = color.key(digits_num - 2)
      return "#{ans[0]}#{ans[1]}#{ans[2]}"
    else
      ohm = ohm.to_i
      ans[0] = color.key(ohm/10)
      ans[1] = color.key(ohm - (ohm/10)*10)
      ans[2] = color.key(0)
      return "#{ans[0]}#{ans[1]}#{ans[2]}"
    end
  else
    return "error"
  end

end

# カラーコード -> 抵抗値(@open_esys)
def c_decode(code)

  color = {"黒" => 0,"茶" => 1,"赤" => 2,"橙" => 3,"黄" => 4,"緑" => 5,"青" => 6,"紫" => 7,"灰" => 8,"白" => 9}

  digit = code.split("")

  error = false
  digit.each{ |io|
    if color[io] == nil
      error = true
    end
  }
  if digit.size != 3
    error = true
  end

  if !error then
    ohm = 0.0
    ohm += color[digit[0]] * 10
    ohm += color[digit[1]]
    ohm = ohm*(10**color[digit[2]])
    digits_num = ohm.to_s.length - 2
    if digits_num >= 4 && digits_num < 7
      ohm = ohm/1000
      # 2.2kΩとかはそのままで10.0Ωとかを10Ωにする
      ohm = ohm.to_s.gsub(/\.0/,"")
      return "#{ohm}kΩ"
    elsif digits_num >= 7
      ohm = ohm/1000000
      ohm = ohm.to_s.gsub(/\.0/,"")
      return "#{ohm}MΩ"
    else
      ohm = ohm.to_s.gsub(/\.0/,"")
      return "#{ohm}Ω"
    end
  else
    return "error"
  end

end
