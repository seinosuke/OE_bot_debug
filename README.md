# @open_esys OEbot

## 召喚の呪文   
　例：OE_bot、OpenEsysBot、おーいーぼっと、など   

## 機能
- **ダレカオルカ**   
「だれかおるか？」、「誰かいますか」などとリプを送ると3L502にいる人がわかります。   
   
- **入退室報告**   
学生証を登録すれば部屋にあるPaSoRiにかざすだけでtwitter上での入退室の報告ができます。   
   
- **esysPinger**   
「きしつ」「機室」を含むリプを送ると、3L504で何台PCが稼働中であるかわかります。
   
- **L棟パンガチャ**   
「L棟パンガチャ」とリプを送ると、L棟２階ラウンジにあるパンの中からランダムでオススメを返します。   
   
- **抵抗値エンコーダ**   
「～Ω」(Ωは必須)のようにリプを送ると4本帯のカラーコードを返します。また、誤差を指定することもできます。（誤差を指定する場合±必須）   
例：100Ω、2.2kΩ、1MΩ±5％   
   
- **カラーコードデコーダ**   
上記のものと逆で、「茶黒赤」のようにリプを送るとその抵抗値を返します。また、同様に「赤黄赤金」のように誤差を指定することもできます。   
（誤差を指定しないと±20％で返します。）   

## 謝辞
- [ktansai](https://github.com/ktansai)さんの[esysPinger](https://github.com/ktansai/esysPinger)を使用させていただきました。ありがとうございます。   
- bunkai_freeさんにL棟パンガチャを提供していただきました。カレーパンです。   
