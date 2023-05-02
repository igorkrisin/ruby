=begin
require 'optparse'

options = {}
OptionParser.new do |opt|
  opt.on('--first_name FIRSTNAME') { |o| options[:first_name] = o }
  opt.on('--last_name LASTNAME') { |o| options[:last_name] = o }
end.parse!

puts options
=end

def fact(num)
  summ = 1
  for i in 1...num+1
    summ *= i
  end
  return summ
end

puts fact(6)

#1*2*3*4*5
#5*4*3*2*1