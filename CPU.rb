require './arithmetic'
require './assembler'
require 'colorize'

def separWordField(word)#разделение полей процессора
    adressField = word.slice(6, 10)
    adressModeField = word.slice(4, 2)
    operationField = word.slice(0,4)

    return [operationField, adressModeField, adressField]
end

#print separWordField("0123456789abcdef")

def memArray()
    mem = []
    for i in 0..1024
	mem.append(convertTo16Bit("0"))
    end
    return mem
end

def check1or0(line)
    for i in 0...line.size-1
        if line[i] != "1" && line[i] != "0"
            raise "ERROR in command file, it's can consist only 0 or 1. Your adress value:  #{line[i]}"
        end
    end
end

def fileRead(nameFile,memory, memAdress, qyanAd)
    #count = 0
    File.readlines(nameFile).each do |line|

        if line.size-1 == 10
            check1or0(line)
            #puts "load adress: #{line}"
            memAdress = line.to_s #адрес в памяти куда сложить команду
            #count += 1

        else
            check1or0(line)
            if line.strip.size != 16
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
     #p memory
end
mem = "000000000"
a =(addition0(mem, "1"))
#puts "a:  #{a}"
#puts "addition0TEST: #{additionBin(mem, a)}"
#print memArray
# arr[i]
# arr+i

def addZero(bin, quan)# эта функция конвертирует число в нужное количество бит за счет добавления нолей
    if(quan > bin.size)
        for i in 0...(quan-bin.size)
            bin = bin + "0"
        end
    end
    return bin
end

def pcBinIncrement(pc)
    return additionBin(pc, addition0(pc, "1"))
end
a = "0000000000000000"
a = pcBinIncrement(a)
p "a1: #{a}"
a = pcBinIncrement(a)
p "a2: #{a}"
a = pcBinIncrement(a)
p "a3: #{a}"
a = pcBinIncrement(a)
p "a4: #{a}"


def mainLoop()
    mar = "0000000000000000"
    mbr = "0000000000000000"
    ir = "0000000000000000"
    pc = 0
    xr = "0000000000000000"
    ac = "0000000000000000"
    memory = memArray
    memAdress = ""
    qyanAd = 0
    fileRead('testing', memory, memAdress, qyanAd)
    while true
        ir = memory[pc]
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
       # p "trace3: "
        #traceRegister(ir, xr, mar, mbr, pc)
        case operatField
            when "0000" 			#HALT
            #traceRegister(ir, xr, mar, mbr, pc)          #TRACER
            break
            when "0001"                         #LOAD
                #p "ac in LOAD: #{memory[convertBinToInt(mar)]}"
                mbr = memory[convertBinToInt(mar)];ac = mbr
                pc+=1
            when "0010" then mbr = memory[convertBinToInt(mar)];memory[convertBinToInt(mar)] = ac #STORE
                #p "mbr in STORE: #{memory[convertBinToInt(mar)]}"
                #p "trace: "
                #traceRegister(ir, xr, mar, mbr, pc)
                pc+=1
            when "0011"	then raise "CALL command is not supported"
            when "0100" then pc = mar           #BR
            when "0101"                         #BREQ
            if(comparisBin(ac, "0") == 0)
                pc = convertBintoInt(mar)
            end
            when "0110" then raise "BRGE (0110) command is not supported"
            when "0111" then raise "BRLT (0111) command is not supported"
            when "1000"                                                                 #ADD
                #p "mbr in ADD: #{memory[convertBinToInt(mar)]}"
                #p "ac in ADD: #{ac}"
                mbr = memory[convertBinToInt(mar)];ac = additionBin(ac, mbr)
                pc+=1
            when "1001" then mbr = memory[convertBinToInt(mar)];ac = subBin(ac, mbr)    #SUB
                pc+=1
            when "1010" then mbr = memory[convertBinToInt(mar)];ac = multBin(ac, mbr)   #MULT
                pc+=1
            when "1011" then mbr = memory[convertBinToInt(mar)];ac = divBin(ac, mbr)    #DIV
                pc+=1
            else  raise "#{operatField} command is not supported"
        end
        traceRegister(ir, xr, mar, mbr, pc, ac)         #TRACER
    end

    print convertBinToInt(ac)
end
#print memArray[convertBinToInt("00000000000000000")]

#TODO написать программу котора складывает 3 числа и кладет результат в 4 ю ячейку
#TODO программа - если в определенной ячейке 0 то программа складыввает одни ячейки, а если не 0 то вычитает другие ячейки

=begin
LOAD @3  складывает из mbr в аккумулятор
ADD 4  складывает аккумулятор и mbr и складывает в аккумулятор
HALT          ничего
DAT 4         ничего
DAT 123     ничего.
!!x=x
!!True=True
!!False = False
!(!!x)=!x
=end


mainLoop()
#p assembler("LOAD @3")
#p desAssemb(assembler("LOAD @3"))


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
