require 'colorize'
require 'optparse'
 
arr = [0,1,2,3,4,5,6,7,8,9]
=begin
options = {}
OptionParser.new do |opt|
  opt.on("--traceOne ") { |o| options[:trace] = o }
  opt.on('--traceКange ') { |o| options[:trace] = o }
end.parse!
=end
=begin
arr = []
options = OpenStruct.new
OptionParser.new do |opt|
opt.on("--list x,y,z", arr, list) do |list|
  options.list = list
end
end.parse!

#puts arr[options[:trace].to_i]
 
def convertTo16Bit(bin)
    for i in 0...(16-bin.size)
        bin = "0" + bin
    end
    return bin
end
 
def convertBinToInt(bin)
    summ = 0
    bin = bin.reverse
    for n in 0...bin.size()
    if(bin[n] == "1")
        summ += (bin[n]).to_i * 2 ** n
    end
    end
    return summ
end
 
def memArray()
    mem = []
    for i in 0..1024
    mem.append(convertTo16Bit("0"))
    end
    return mem
end
memArr = memArray()
memArr[2] = "0101010100000"
 
def traceBitMemory(index, memArr)
    #arr = [0,1,2,3,4,5,6,7,8,9]
    if index.length == 0
        raise "the trace index for memory is empty"
    end
    if index.match(/^[0-9]+$/) && index.to_i >=0 && index.to_i <= 1024
        print " |#{memArr[index.to_i]}(#{convertBinToInt(memArr[index.to_i]).to_s.yellow})| "
         
    elsif index.match(/^[0-9]*[-].[0-9]*$/)
        temp =  index.split('-')
        startInd = temp[0]
        finishInd = temp[1]
        if startInd.to_i < 0 || startInd.to_i > 1024 
            raise "wrong the range index for memory in trace bit memory --#{startInd}--"
        end
        if finishInd.to_i < 0 || finishInd.to_i > 1024 
            raise "wrong the range index for memory in trace bit memory --#{finishInd}--"
        end
        for i in startInd.to_i..finishInd.to_i
            print " |#{memArr[i]}(#{convertBinToInt(memArr[i]).to_s.yellow})| "
        end
        
    else
        raise "wrong a memory index in trace bit memory --#{index}--"
    end
    
end
 
memArray = memArray()
#traceBitMemory(options[:trace], memArr)
=end
a = "asdfghj\n"
p a.index("\n")
p a.include? "\n"
p a.delete("\n")
