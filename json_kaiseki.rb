# -*- coding: utf-8 -*-
require 'json'

filename1 = "left_goal_position.txt" #leftチームがゴールするまでの50ステップ間の試合状態を保存するファイル
filename2 = "right_goal_position.txt" #right
#filename3 = "ball_position.txt"

#file = File.open("posi.txt","w+")  
file_l = File.open(filename1,"w+")
file_r = File.open(filename2,"w+")

count = 1   #大元の繰り返しをカウントする
count2 = 1  #選手の位置を配列に格納するときに使う

def make_nm_array(n,m)  #要素が空(nil)の、n×ｍの２次元配列を作る
  (0...n).map { Array.new(m) }
end

position = make_nm_array(6001,47)
goal_l=[]  #左チームが得点した時の時刻を代入
goal_r=[]  #右チームが得点した時の時刻を代入
 
#6000ステップ分の配列を作成するが0番目は無視
#時間、ボールの位置(x,y),leftチームの選手の位置(x,y),rightチームの選手の位置(x,y)の順に配列に格納



#json.txtというファイルにjsonのデータのファイル名を格納し、1行ずつ読み込んで実行させる

txtfile = File.open("json.txt")
txtfile.each_line do  |line|#txtファイル中にあるファイル名を1行ずつ読み込む
json_data = JSON.load(File.read(line.chomp)) #.chompは末尾の改行文字を削除した文字列を返してくれる
puts line.chomp + "start.\n" 
#------------------------------------------------------------------------------------------------------------
  json_data.each do |datan|  #大元の繰り返し,JSONデータの配列すべてに関して
    data = datan
    play_mode = data['playmode']
    show = data['show']
    time = show['time']
    ball = show['ball']
    left = show['left']
    right= show['right']

    if play_mode != nil then #playmodeキーの値がnilでなければ
      playmode = play_mode['playmode'] #playmodeキーの値のキーになっているplaymodeキーの値を取得
      if playmode == "goal_l" then   #その値がgoal_lなら
        puts "left"
        p goal_l.push(time.to_i)
      end
      if playmode == "goal_r" then   #その値がgoal_rなら
        puts "right"
        p goal_r.push(time.to_i)
      end
    end
    
    if time.to_i == count then
      position[count][0]=time.to_i #配列の[1〜6000][0]番目の要素に時間を代入
      
      #ボールの位置を格納
      position[count][count2]=ball[0].to_f
      position[count][count2+1]=ball[1].to_f
      count2 = count2 + 2
      #leftチームの位置を格納
      left.each do |l|
        position[count][count2]=l[1].to_f
        position[count][count2+1]=l[2].to_f
        count2 = count2 + 2
      end
      #rightチームの位置を格納
      right.each do |r|
        position[count][count2]=r[1].to_f
        position[count][count2+1]=r[2].to_f
        count2 = count2 + 2
      end
      count2 = 1 #count2をリセット
      count +=1
      #3000ステップ目はカウントされないみたいなので、countが3000になった時の場合を考える
    elsif count == 3000 then
      count = 3001
      position[count][0]=time.to_i
      #ball
      position[count][count2]=ball[0].to_f
      position[count][count2]=ball[1].to_f
      count2 = count2 + 2
      #left_team
      left.each do |l|
        position[count][count2]=l[1].to_f
        position[count][count2+1]=l[2].to_f
        count2 = count2 + 2
      end
      #right_team
      right.each do |r|
        position[count][count2]=r[1].to_f
        position[count][count2+1]=r[2].to_f
        count2 = count2 + 2
      end
      count2 = 1 #count2をリセット
      count += 1
    end
    
  end

#-------------------------------------------------------------------------------------------------------------
#ゴールするまでの50ステップ間の試合状態をファイルに出力

  position.each do |po|
    if po[0] != nil then #要素が空でない時
      # file.puts "#{po}\n" #"posi.txtに配列の中身を出力"
      goal_l.each do |l| #leftチームがゴールする時刻までの50ステップ間の情報を記録
        if po[0] > l-51 && po[0] < l+1 then
          file_l.puts "#{po}\n"
        end
      end
      goal_r.each do |r| #rightチームが…
        if po[0] > r-51 && po[0] < r+1 then
          file_r.puts "#{po}\n"
        end
      end
    end
  end
#-------------------------------------------------------------------------------------------------------------
goal_l.clear #配列を空にする（破壊的メソッド）
goal_r.clear 
puts line.chomp + "finish.\n" 
end
file.close

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
