# h2タグのチェック
def h2_check(sentence)
  h2 = sentence.match(/^■/)
  if h2.nil?
    sentence = sentence
  else
    sentence = sentence.sub(/^■/, "") 
    sentence = "<h2>#{sentence}</h2>"
  end
end

# h3タグのチェック
def h3_check(sentence)
  h3 = sentence.match(/^□/)
  if h3.nil?
    sentence = sentence
  else
    sentence = sentence.sub(/^□/, "") 
    sentence = "<h3>#{sentence}</h3>"
  end
end

# チェックマークのチェック
def point_check(sentence)
  pointcheck = sentence.match(/^✓/)
  if pointcheck.nil?
    sentence = sentence
  else
    sentence = sentence.sub(/^✓/, "") 
    sentence = "<p class=\"point\">#{sentence}</p>"
  end
end

# ulliタグのチェック
def ulli_check(sentence)
  ullicheck = sentence.match(/^・/)
  if ullicheck.nil?
    # ulタグの閉じタグを閉じるために分岐させる
    if $ul_flg != 0
      $ul_flg = 0
      sentence = "</ul>\n#{sentence}"
    else
      sentence = sentence
    end
  else
    if $ul_flg == 0
      $ul_flg = 1
      sentence = sentence.sub(/^・/, "")
      sentence = "<ul>\n <li>#{sentence}</li>"
    else
      sentence = sentence.sub(/^・/, "") 
      sentence = " <li>#{sentence}</li>"
    end
  end
end

# チェックしたいマークがあれば、ここにメソッドを追加していく

# ulタグの初期化
$ul_flg = 0

puts "マークアップしたいテキストファイルをドラッグ＆ドロップしてください"

filepath = gets.chomp
filepath = filepath.sub(/^'/, "") 
filepath = filepath.sub(/'$/, "") 

file = File.open(filepath, "a+")
sentences = file.read().split("\n")
sentences = sentences.map do |sentence|
  sentence.chomp
  sentence = h2_check(sentence)
  sentence = h3_check(sentence)
  sentence = point_check(sentence)
  sentence = ulli_check(sentence)
  # メソッドを上に追加したらここで呼び出す
end

file.puts "\n\nー・ー・ー・ー・ー・ー・ー・ー\n\n"
file.puts "\n【ここからマークアップした文章】\n"
file.puts sentences
file.close

