require 'colorize'
require 'optparse'
 
arr = [0,1,2,3,4,5,6,7,8,9]
 
options = {}
OptionParser.new do |opt|
  opt.on('--traceOne ') { |o| options[:trace] = o }
  opt.on('--traceRange ') { |o| options[:trace] = o }
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
    if index.match(/^[0-9]+([,]?[0-9]?)*$/) && index.to_i >=0 && index.to_i <= 1024
      regex = index.match(/^[0-9]+([,]?[0-9]?)*$/)[0].split(",")
      #p regex[1]
      for i in 0...regex.length
        
        inc = regex[i].to_i
        if inc < 0 || inc > 1024
          raise "wrong the range index for memory in trace bit memory --#{inc}--"
        end
        print "mem[#{inc.to_s.red}] #{memArr[inc]}(#{convertBinToInt(memArr[inc]).to_s.yellow}) "
      end
         
    elsif index.match(/^([0-9]*[-][0-9]*),([\d,]+)$/)

        temp =  index.match(/^([0-9]*[-][0-9]*),([\d,]+)$/)[1].split("-")
        startInd = temp[0]
        finishInd = temp[1]
        indexIncrement = index.match(/^([0-9]*[-][0-9]*),([\d,]+)$/)[2].split(",")
        #puts  "indexINcr: #{indexIncrement}"
        if startInd.to_i < 0 || startInd.to_i > 1024 
            raise "wrong the range index for memory in trace bit memory --#{startInd}--"
        end
        if finishInd.to_i < 0 || finishInd.to_i > 1024 
            raise "wrong the range index for memory in trace bit memory --#{finishInd}--"
        end
        for i in startInd.to_i..finishInd.to_i
            print "mem[#{i.to_s.red}]#{memArr[i]}(#{convertBinToInt(memArr[i]).to_s.yellow})| "
        end
        for i in 0...indexIncrement.length
          #puts "test!"
          if indexIncrement[i].to_i < 0 || indexIncrement[i].to_i > 1024
            
            raise "wrong the range index for memory in trace bit memory --#{indexIncrement}--"
          end
          indInt = indexIncrement[i].to_i
          print "mem[#{indInt.to_s.red}]#{memArr[indexIncrement[i].to_i]}(#{convertBinToInt(memArr[indexIncrement[i].to_i]).to_s.yellow})| "
        end
        
    else
        raise "wrong a memory index in trace bit memory --#{index}--"
    end
    
end
 
memArray = memArray()
traceBitMemory(options[:trace], memArr)