require 'colorize'
require 'optparse'
require './arithmetic.rb'
require './assembler.rb'

def dataInstruc()
    sourceCode =File.read("mnemonic.asm")
    tempArr = sourceCode.split("\n")
    objectFile = ""
    for i in 0...tempArr.size
        if tempArr[i][0] == "#"
            next
        elsif  tempArr[i] == ""
            next
        elsif tempArr[i].match(/ORG\s+([0-9]+)/)
            temp = tempArr[i].match(/ORG (.*)/)
            objectFile += addition0Param(10, convertDecToBin(temp[1].to_i).to_s)+"\n"

        elsif tempArr[i].match(/(DATA\s+)([0-9]+\s*)([,]\s*[0-9]+\s*)/)
            dataArr = tempArr[i].match(/DATA (.*)/)
            dataArr = dataArr[1].split(',')
            for y in 0...dataArr.size
                objectFile += convertTo16Bit(convertDecToBin(dataArr[y].to_i))+"\n"
            end
        else
            objectFile += assembler(tempArr[i])+"\n"

        end
    end
    File.write('testing.obj', objectFile)
end

dataInstruc()

def desAssemb(command)
    finishText = ""
    operatField, adressModeField, adressField = separWordField(command)
    case operatField
        when "0000" then return "HALT"
        when "0001" then finishText += "LOAD"
        when "0010" then finishText += "STORE"
        when "0011" then finishText += "CALL"
        when "0100" then finishText += "BR"
        when "0101" then finishText += "BREQ"
        when "0110" then finishText += "BRGE"
        when "0111" then finishText += "BRLT"
        when "1000" then finishText += "ADD"
        when "1001" then finishText += "SUB"
        when "1010" then finishText += "MUL"
        when "1011" then finishText += "DIV"
        else
	    raise "the command in desAssembler is wrong:  #{operatField}"
    end
    finishText = finishText + " "
    case adressModeField
	when "00" then finishText = finishText + ""
	when "01" then finishText = finishText + "="
	when "10" then finishText = finishText + "$"
	when "11" then finishText = finishText + "@"
    end
    finishText = finishText + convertBinToInt(adressField).to_s

    return finishText
end


def fileRead(nameFile,memory, memAdress)
    File.readlines(nameFile).each do |line|
        if line.size-1 == 10
            check1or0(line)
            if line.include? "\n"
               line = line.delete("\n")
            end
            memAdress = line.to_s #адрес в памяти куда сложить команду
        else
            check1or0(line)
            if line.strip.size != 16
                raise "ERROR in command file, size command line can be only 16 piece. Your value: #{line.size}"
            end
            memory[convertBinToInt(memAdress)] = line.to_s.strip
            memAdress = additionBin(memAdress, addition0Param(memAdress.size, "1"))
        end
     end
end



def mainLoop()
    options = {}
    OptionParser.new do |opt|
    opt.on('--traceOne ') { |o| options[:trace] = o }
    opt.on('--traceRange ') { |o| options[:trace] = o }
    end.parse!
    index = 4
    mar = "0000000000000000"
    mbr = "0000000000000000"
    ir = "0000000000000000"
    pc = "0000000000"
    xr = "0000000000"
    ac = "0000000000000000"
    memory = memArray
    memAdress = ""
    qyanAd = 0
    fileRead('testing.obj', memory, memAdress)
    while true
        ir = memory[convertBinToInt(pc)]
        #p "ir:  #{ir} pc: #{pc}"
        #p "memory: #{memory[4]}"
        operatField, adressModeField, adressField = separWordField(ir)

        case adressModeField
            when "00"               #Direct mode    (none)
                mar = adressField
            when "01"               #Immediate mode (=)
                mar = adressField
                mbr = convertTo16Bit(mar)
            when "10"               #Indexed mode   ($)
                mar = adressField
                mar = additionBin(mar, xr)
            when "11"               #Inderect mode  (@)"
                mar = adressField
                mbr = memory[convertBinToInt(mar)]
                mar = convertTo16Bit(mbr.slice(5,11))#??? TODO правмльно ли записаны индексы? в adress field записаны с 6 по 10
        end
        case operatField
            when "0000" 			                        #HALT
            #p "operatField: #{operatField}"
            traceRegister(ir, xr, mar, mbr, pc, ac,index)         #TRACER
            break
            when "0001"                                     #LOAD
                if adressModeField != '01'
                    mbr = memory[convertBinToInt(mar)];
                end
                ac = mbr
                pc = binIncrement(pc)
            when "0010" 						#STORE
        	if convertBinToInt(mar) == 0
        	    xr = ac.slice(6, 10)
        	else
            	    if adressModeField != '01'
                	mbr = memory[convertBinToInt(mar)]
            	    end
            	    memory[convertBinToInt(mar)] = ac               
            	end
            	pc = binIncrement(pc)
            when "0011"					                    #CALL
        	mbr = convertTo16Bit(binIncrement(pc))
            #p "mbr in CALL: #{ binIncrement(pc)}"
        	memory[convertBinToInt(mar)] = mbr
        	pc = mar
        	pc = binIncrement(pc)
            when "0100" then pc = mar                         #BR
            when "0101"                                       #BREQ
            if(comparisBin(ac, "0") == 0)
                pc = mar
            else
        	pc = binIncrement(pc)
            end
            when "0110" then raise "BRGE (0110) command is not supported"
            when "0111" then raise "BRLT (0111) command is not supported"
            when "1000"                                         #ADD
                #p "mbr in ADD: #{memory[convertBinToInt(mar)]}"
                #p "ac in ADD: #{ac}"
                if adressModeField != '01'
                    mbr = memory[convertBinToInt(mar)]
                end
                ac = additionBin(ac, mbr)
                pc = binIncrement(pc)
            when "1001"                                        #SUB
                if adressModeField != '01'
                    mbr = memory[convertBinToInt(mar)]
                end
                ac = subBin(ac, mbr)    
                pc = binIncrement(pc)
            when "1010"                                        #MULT
                if adressModeField != '01'
                    mbr = memory[convertBinToInt(mar)]
                    #p "mbr: #{mbr}"
                end
                #p "ac1: #{ac}" 
                ac = multBin(ac, mbr) 
                #p "ac2: #{ac}" 
                pc = binIncrement(pc)
            when "1011"                                         #DIV
                if adressModeField != '01'
                    mbr = memory[convertBinToInt(mar)]
                end
                ac = divBin(ac, mbr)    
                pc = binIncrement(pc)
            else  raise "#{operatField} command is not supported"
        end
        traceRegister(ir, xr, mar, mbr, pc, ac, index)                 #TRACER
    end
    if options[:trace] != nil
        traceBitMemory(options[:trace], memory)
    end
    #p "\nmemory in 628: #{memory}"
    puts "\nresult: #{convertBinToInt(ac)}"
end


def traceRegister(ir, xr, mar, mbr, pc, ac, index)
    puts "ir: #{ir.slice(0,4).red}#{ir.slice(4,2).green}#{ir.slice(6,10).blue}(#{desAssemb(ir).yellow}); xr: #{xr}(#{convertBinToInt(xr).to_s.yellow}); mar: #{mar}(#{convertBinToInt(mar).to_s.yellow}); mbr: #{mbr}(#{convertBinToInt(mbr).to_s.yellow}); pc: #{pc}(#{convertBinToInt(pc).to_s.yellow}); ac: #{ac}(#{convertBinToInt(ac).to_s.yellow})) "
end

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
                       #^([0-9]*[-][0-9]*),?([\d,]+)?$
    elsif index.match(/^([0-9]+[-][0-9]+),?([\d,]+)?$/)

        temp =  index.match(/^([0-9]+[-][0-9]+),?([\d,]+)?$/)[1].split("-")
        startInd = temp[0]
        finishInd = temp[1]
        
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
        if index.match(/^([0-9]+[-][0-9]+),?([\d,]+)?$/)[2] != nil
            indexIncrement = index.match(/^([0-9]+[-][0-9]+),?([\d,]+)?$/)[2].split(",")
            for i in 0...indexIncrement.length
            #puts "test!"
            if indexIncrement[i].to_i < 0 || indexIncrement[i].to_i > 1024
                
                raise "wrong the range index for memory in trace bit memory --#{indexIncrement}--"
            end
            indInt = indexIncrement[i].to_i
            print "mem[#{indInt.to_s.red}]#{memArr[indexIncrement[i].to_i]}(#{convertBinToInt(memArr[indexIncrement[i].to_i]).to_s.yellow})| "
            end
        end
        
    else
        raise "wrong a memory index in trace bit memory --#{index}--"
    end
    
end
 
#traceBitMemory(options[:trace], memArr)
mainLoop()
#p assembler("LOAD @3")
#p desAssemb(assembler("LOAD @3"))
=begin

план на CPU:
1) вывести управление трасировкой в опции командной строки
2) добавить в ассемблер мнемонические метки
3) закодить на ассемблере пару сортировок
4) добавить отрицательные числа через дополнительный код
5) опционально: исследовать троичную систему счисления для представления отрицательных чисел
6) перейти к второму процессору из второй части книги
7) закодить на ассемблере рекурсивный факториал и фибоначчи
8) может еще что-то. ввод-вывод, например

LOAD @3  складывает из mbr в аккумулятор
ADD 4  складывает аккумулятор и mbr и складывает в аккумулятор
HALT          ничего
DAT 4         ничего
DAT 123     ничего
!!x=x
!!True=True
!!False = False
!(!!x)=!x
=end


=begin
35
35  0 10
 5
 --
 50
  0
01
10
00
11
01011 = ...+1*2^1+1*2^0
    134-128 = 6 - 4 = 2-2 = 0
	 1   0  0 0  0 1 1 0
  256 128 64 32 16 8 4 2 1
    458%10 == 8
    458/10== 45
   0101/2 == 010
   0101%2 == 1
   458 % 2 = 0
  458/2=
   convertToBin(42) -> "010101"
=end
 #сложение двух чисел в бинарной записи
        #memory[0] = "0001" + "11" + "0000000011"
        #memory[1] = "1000" + "00" + "0000000100"
        #memory[3] = convertTo16Bit(convertDecToBin(4))
        #memory[4] = convertTo16Bit(convertDecToBin(231))
    #сложение двух чисел в записи assembler
        #memory[0] = assembler("LOAD @3")#  возми адрес в 3 ей ячейке(куда надо обратиться) и загрузи содержимое из этой (четвертой) ячейки в аккумулятор
        #memory[1] = assembler("ADD 4") # сложи то что есть в четвертой ячейки с аккумулятором
        #memory[2] = assembler("HALT") #останови процессор
        #memory[3] = convertTo16Bit(convertDecToBin(4))
        #memory[4] = convertTo16Bit(convertDecToBin(22))
    # сложение 3х числел и помещение результата сложения в отдельную ячейку
        #memory[0] = assembler('LOAD 5')

        #memory[1] = assembler('ADD 6')
        #memory[2] = assembler('ADD 7')
        #memory[3] = assembler('STORE 8')

        #memory[4] = assembler('HALT')
        #p memory
        #memory[5] =  convertTo16Bit(convertDecToBin(4))#"0010000000000000"
        #memory[6] = convertTo16Bit(convertDecToBin(6))
        #memory[7] = convertTo16Bit(convertDecToBin(5))
    # если в ячейке n лежит 0, то сложи одни ячейки, если не 0 то вычти другие
    # поменяй местами 2 ячейки

        #memory[0] = assembler('LOAD 2')
        #memory[1] = assembler('STORE 5')

        #memory[2] = convertTo16Bit(convertDecToBin(4))
        #memory[3] =  convertTo16Bit(convertDecToBin(7))

        #memory[4] =  convertTo16Bit(convertDecToBin(6))
        #p "memory[2] = : #{memory[2]}"
        #p "memory[3] = : #{memory[3]}"
        #p "memory[5] = : #{memory[5]}"