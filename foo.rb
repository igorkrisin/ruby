require 'optparse'

options = {}
OptionParser.new do |opt|
  opt.on('--first_name FIRSTNAME') { |o| options[:first_name] = o }
  opt.on('--last_name LASTNAME') { |o| options[:last_name] = o }
end.parse!

puts options