# -*- coding: utf-8 -*-
require 'json'

#変数json_dataに引数で指定したfileを
json_data = JSON.load(File.read(ARGV[0])) 


json_data.each do |datan|
data = datan 
show = data['show']
time = show['time']
ball = show['ball']
left = show['left']
right= show['right']

#puts "#{time} (#{ball[0].to_i},#{ball[1].to_i})"
puts "left"
  left.each do |l|
    puts "#{time} [#{l[0].to_i}] (#{l[1].to_i},#{l[2].to_i})"
  end
end


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
