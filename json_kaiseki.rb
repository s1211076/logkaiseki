# -*- coding: utf-8 -*-
require 'json'

#変数json_dataに引数で指定したfileを
json_data = JSON.load(File.read(ARGV[0])) 
filename1 = "left_position.txt"
filename2 = "right_position.txt"
filename3 = "ball_position.txt"

file = File.open("posi.txt","w+")

count = 1   #大元の繰り返しをカウントする


def make_nm_array(n,m)  #要素が空(nil)の、n×ｍの２次元配列を作る
  (0...n).map { Array.new(m) }
end

position = make_nm_array(6001,47) 
#6000ステップ分の配列を作成するが0番目は無視
#時間、ボールの位置(x，y)、leftチームの選手の位置(x，y)、rightチームの選手の位置（x，y）の順に配列に格納

json_data.each do |datan|  #大元の繰り返し
  data = datan 
  show = data['show']
  time = show['time']
  ball = show['ball']
  left = show['left']
  right= show['right']

  if time.to_i == count then
    position[count][0]=time.to_i
    count +=1
   elsif count == 3000 then
    count = 3001
    position[count][0]=time.to_i
    count += 1

  end
end

position.each do |po|
 file.puts "#{po}\n" #"posi.txtに配列の中身を出力"
end
=begin
#ファイルに出力する部分は今回は使わない

 file1 = File.open(filename1,"a+") do |file1| #"a+":ファイルの末尾に追加
  file1.puts "time:#{time}"
  left.each do |l|
    file1.puts "[#{l[0].to_i}] (#{l[1].to_f},#{l[2].to_f})"
  end
 end

file2 = File.open(filename2,"a+") do |file2| #"a+":ファイルの末尾に追加
  file2.puts "time:#{time}"
  right.each do |r|
    file2.puts "[#{r[0].to_i}] (#{r[1].to_f},#{r[2].to_f})"
  end
 end

file3 = File.open(filename3,"a+") do |file3| #"a+":ファイルの末尾に追加
    file3.puts "time:#{time} (#{ball[0].to_f},#{ball[1].to_f})"
 end

end
=end


#data_hash = JSON.parse(file) 
#jsonテキストをハッシュにパースするがデータが配列になっているのでうまくいかない。。。
=begin
file = File.read(ARGV[0])

File.open("json_hash.txt","w") do |file|
data_hash.each{|k,v| file.puts "key:#{k} value:#{v}"}
end

File.open("json_hash2.txt","w") do |file|
  JSON.load(fi,proc{|v| file.puts v })
end

=end
