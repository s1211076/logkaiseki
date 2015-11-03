# -*- coding: utf-8 -*-
require 'json'

#変数json_dataに引数で指定したfileを
json_data = JSON.load(File.read(ARGV[0])) 

data1 = json_data[0]
show = data1['show']
ball = show['ball']
left = show['left']
right= show['right']


p ball[0].to_i
p left
p right

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
