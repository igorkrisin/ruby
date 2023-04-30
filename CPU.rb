require 'colorize'
require './arithmetic.rb'
require './assembler.rb'

def fileRead(nameFile,memory, memAdress)
    #count = 0
    File.readlines(nameFile).each do |line|

        if line.size-1 == 10
            check1or0(line)
            #puts "load adress: #{line}"
            memAdress = line.to_s #адрес в памяти куда сложить команду
            #count += 1

        else
            check1or0(line)
            puts "line.strip1: #{line.strip}"
            if line.strip.size != 16
                puts "line.strip2: #{line.strip}"
                raise "ERROR in command file, size command line can be only 16 piece. Your value: #{line.size}"
            end
            #puts "commands: #{line}" #line -это команда которую выполняем в из файла по адресу memAdress
            #puts "memAdress: #{memAdress}"
            #puts "addition0: #{addition0(memAdress, "1")}"
            #puts "line.to_s.strip: #{line.to_s.strip}"
            memory[convertBinToInt(memAdress)] = line.to_s.strip
            memAdress = additionBin(memAdress, addition0(memAdress, "1"))
        end

     end
    
end


def mainLoop()
    mar = "0000000000000000"
    mbr = "0000000000000000"
    ir = "0000000000000000"
    pc = "0000000000"
    xr = "0000000000000000"
    ac = "0000000000000000"
    memory = memArray
    memAdress = ""
    qyanAd = 0
    fileRead('testing', memory, memAdress)
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
                mbr = mar
            when "10"               #Indexed mode   ($)
                mar = adressField
                mar = mar + xr
            when "11"               #Inderect mode  (@)"
                mar = adressField
                mbr = memory[convertBinToInt(mar)]
                mar = convertTo16Bit(mbr.slice(5,11))
                                        #indirect mode
        end
        #todo LOAD =2 ==> 2<-ac
       # p "trace3: "
        #traceRegister(ir, xr, mar, mbr, pc)
        case operatField
            when "0000" 			#HALT
            #p "operatField: #{operatField}"
            traceRegister(ir, xr, mar, mbr, pc, ac)          #TRACER
            break
            when "0001"                         #LOAD
                #p "ac in LOAD: #{memory[convertBinToInt(mar)]}"
                mbr = memory[convertBinToInt(mar)];ac = mbr
                pc = binIterator(pc)
            when "0010" then mbr = memory[convertBinToInt(mar)];memory[convertBinToInt(mar)] = ac #STORE
                #puts "convertBinToInt(mar): #{convertBinToInt(mar)}"
                #p "mbr in STORE: #{memory[convertBinToInt(mar)]}"
                #p "trace: "
                #traceRegister(ir, xr, mar, mbr, pc)
                pc = binIterator(pc)
            when "0011"	then raise "CALL command is not supported"
            when "0100" then pc = mar           #BR
            when "0101"                         #BREQ
            if(comparisBin(ac, "0") == 0)
                pc = mar
            else
        	pc = binIterator(pc)#binIncrement - rename this function
            end
            when "0110" then raise "BRGE (0110) command is not supported"
            when "0111" then raise "BRLT (0111) command is not supported"
            when "1000"                                                                 #ADD
                #p "mbr in ADD: #{memory[convertBinToInt(mar)]}"
                #p "ac in ADD: #{ac}"
                mbr = memory[convertBinToInt(mar)];ac = additionBin(ac, mbr)
                pc = binIterator(pc)
            when "1001" then mbr = memory[convertBinToInt(mar)];ac = subBin(ac, mbr)    #SUB
                pc = binIterator(pc)
            when "1010" then mbr = memory[convertBinToInt(mar)];ac = multBin(ac, mbr)   #MULT
                pc = binIterator(pc)
            when "1011" then mbr = memory[convertBinToInt(mar)];ac = divBin(ac, mbr)    #DIV
                pc = binIterator(pc)
            else  raise "#{operatField} command is not supported"
        end
        traceRegister(ir, xr, mar, mbr, pc, ac)         #TRACER
    end
    #p "\nmemory in 628: #{memory}"
    print convertBinToInt(ac)
end

def traceRegister(ir, xr, mar, mbr, pc, ac)
    puts "ir bin: #{ir.slice(0,4).red}#{ir.slice(4,2).green}#{ir.slice(6,10).blue} (#{desAssemb(ir).yellow}); xr: #{xr}(#{convertBinToInt(xr).to_s.yellow}); mar: #{mar}(#{convertBinToInt(mar).to_s.yellow}); mbr: #{mbr}(#{convertBinToInt(mbr).to_s.yellow}); pc: #{pc}(#{convertBinToInt(pc).to_s.yellow}); ac: #{ac}(#{convertBinToInt(ac).to_s.yellow}) "
end

mainLoop()
#p assembler("LOAD @3")
#p desAssemb(assembler("LOAD @3"))
=begin
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