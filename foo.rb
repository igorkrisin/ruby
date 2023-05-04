require 'optparse'
require 'ostruct'
require './arithmetic.rb'
=begin
a = ["1","2","3"]
options = OpenStruct.new
OptionParser.new do |opt|
  opt.on('-f', '--first_name FIRSTNAME', 'The first name') { |o| a[options.first_name] = o }
  opt.on('-l', '--last_name LASTNAME', 'The last name') { |o| options.last_name = o }
end.parse!

puts a[options.first_name]
=end

def memArray()
  mem = []
  for i in 0..1024
mem.append(convertTo16Bit("0"))
  end
  return mem
end


def traceMemoryBit(indexStart)
  
  if indexStart.split('-').size > 1
    index = indexStart.split('-')
    if(indexStart.split('-')[0].to_i >= 0 && indexStart.split('-')[0].to_i <= 1024 && indexStart.split('-')[1].to_i >= 0 && indexStart.split('-')[1].to_i <=1024)
      for i in index[0].to_i...index[1].to_i
        puts "indexStart[0]: #{index[0]}"
        puts "indexStart[1]: #{index[1]}"
        print memArray[i]
      end
    else
      
      print "out of range"
    end
  elsif indexStart.split().size == 1
    if(indexStart.split[0].to_i.to_i >= 0 && indexStart.split[0].to_i <= 1024)
      p "==1"
      print memArray[indexStart.to_i]
    else
    print "out of range"
    end
  else
    print "index empty"
  end
end

traceMemoryBit("4")
=begin
def fact(num)
  summ = 1
  for i in 1...num+1
    summ *= i
  end
  return summ
end

puts fact(6)
=end
#1*2*3*4*5
#5*4*3*2*1