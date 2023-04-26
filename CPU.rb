require 'colorize'

def convertDecToBin(dec)

    summ = ""
    while dec != 0 && dec !=1
	    summ = (dec%2).to_s + summ
	    dec = dec/2
    end
    summ = dec.to_s + summ

end


#puts convertDecToBin(458)


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

#puts convertBinToInt("111001010")

def convertBinToHex(bin)
    summ = ""
    tmp = 0
    bin = bin.reverse
    for i in (0...bin.size()).step(4)
        for j in 0...4
            if bin[i+j] == "1"
                if(j == 0)
                    tmp += 1
                elsif(j == 1)
                    tmp += 2
                elsif(j == 2)
                    tmp += 4
                elsif(j == 3)
                    tmp += 8

                end
            end

        end
        if tmp >= 10
            if tmp == 10
                summ = "A" + summ
            elsif tmp == 11
                summ = "B" + summ
            elsif tmp == 12
                summ = "C" + summ
            elsif tmp == 13
                summ = "D" + summ
            elsif tmp == 14
                summ = "E" + summ
            elsif tmp == 15
                summ = "F" + summ
            end
            tmp = 0
            next
        end
        summ = tmp.to_s + summ
        #puts tmp
        tmp = 0

    end

    return summ
end

#puts convertBinToHex("00110010010111001111")

def convertHexToBin(hex)
    summ = ""
    hex = hex.reverse
    for i in 0...hex.size()
        if hex[i] == "A"
            summ = convertDecToBin(10) + summ
        elsif hex[i] == "B"
            summ = convertDecToBin(11) + summ
        elsif hex[i] == "C"
            summ = convertDecToBin(12) + summ
        elsif hex[i] == "D"
            summ = convertDecToBin(13) + summ
        elsif hex[i] == "E"
            summ = convertDecToBin(14) + summ
        elsif hex[i] == "F"
            summ = convertDecToBin(15) + summ
        else
            summ = convertDecToBin((hex[i]).to_i) + summ
        end
    end
    return summ
end

#puts convertHexToBin("1FAC")

def convertBinToOct(bin)
    summ = ""
    bin = bin.reverse
    tmp = 0
    for i in (0...bin.size()).step(3)
        for j in 0...3
            if bin[i+j] == "1"
                if(j == 0)
                    tmp += 1
                elsif(j == 1)
                    tmp += 2
                elsif(j == 2)
                    tmp += 4
                end
            end
        end
        if tmp == 0
            next
        end
        summ = tmp.to_s + summ
        tmp = 0
    end
    return summ
end

#puts convertBinToOct("11001100111101101")

def removeFirst0(bin)

    while bin[0] != "1"
        bin.slice!(0)
    end
return bin

end

#puts removeFirst0("0000111")


def convertOctToBin(oct)
    octStr = oct.to_s
    temp = ""
    count = 0
    for i in 0...(oct.to_s).size()
        for y in (4).downto(1)
            if y == 4 || y == 2 || y == 1
                if octStr[i].to_i < y
                    temp = temp + "0"
                    next
                elsif octStr[i].to_i >= y
                    temp = temp + "1"
                    octStr[i] = (octStr[i].to_i - y).to_s
                end
            end
        end
    end
    return temp

end

#puts convertOctToBin(321)


def additionBin(bin1, bin2)
    carry = 0
    summ = ""
    for i in (bin1.size()-1).downto(0)
	    temp = bin1[i].to_i+bin2[i].to_i+carry
	    summ = (temp%2).to_s + summ
	    carry = temp/2
    end
    return summ
end

def addition0(bin1, bin2)

    if bin1.size>bin2.size
        while bin1.size() != bin2.size()

            bin2 = "0" + bin2
        end
    end
    p bin2
    return bin2
end

def addition0Param(quantity, bin2)
    if quantity > bin2.size
        while quantity != bin2.size()
            bin2 = "0" + bin2
        end
    end
    return bin2
end

#print addition0Param(10, "01010")
#puts additionBin("1010", "1010")
#puts addition0("010101", "1")

def convertTo16Bit(bin)
    for i in 0...(16-bin.size)
        bin = "0" + bin
    end
    return bin
end

def subBinNew(bin1, bin2)
    bin1 = convertTo16Bit(bin1)
    bin2 = convertTo16Bit(bin2)
    for i in 0...bin2.size()
        if bin2[i] == "0"
            bin2[i] = "1"
        else
            bin2[i] = "0"
        end
        #puts bin2[i]
    end
    #puts bin2
    temp = additionBin(bin2, addition0(bin2, "1"))
    #puts temp
    summ = additionBin(bin1, temp)
    if(summ.size() > bin1.size())
        summ[0] = ""
    end
    return summ
end

#puts subBinNew("100", "11")


def subBin(bin1, bin2)
    bin1 = convertTo16Bit(bin1)
    bin2 = convertTo16Bit(bin2)
    summ = ""
    borrow = 0
    for i in (bin1.size()-1).downto(0)
        temp = (bin1[i].to_i - borrow) - bin2[i].to_i
        if temp == 0 || temp == 1
            #print "temp: #{temp}\n"
            summ = temp.to_s + summ
            borrow = 0
            #print "summ if: #{summ}\n"
        elsif temp == -1 && borrow == 0
            #print "summ before: #{summ}\n"
            borrow = 1
    	    summ = "1" + summ
            #print "summ after: #{summ}\n"
        else
            summ = (bin1[i].to_i+borrow - bin2[i].to_i).to_s + summ
        end
    end

    return  summ
end
#puts  subBin("11111", "010")




#"575"
#"997"

def comparisDec(dec1, dec2)
    if dec1.size < dec2.size
	    dec1 = addition0(dec2, dec1)
    elsif dec1.size > dec2.size
	    dec2 = addition0(dec1, dec2)
    end
    for i in 0...(dec1.to_s).size()
        if dec1[i].to_i < dec2[i].to_i
            return -1
        elsif dec1[i].to_i > dec2[i].to_i
            return 1
        end
    end
    return 0
end


#puts comparisDec("0050", "50")

def separDivNum(dec1, dec2)
    temp = ""
    for i in 0...dec1.size
        temp = temp + dec1[i]
        if comparisDec(temp, dec2) == 1 || comparisDec(temp, dec2) == 0
            return [temp, dec1.slice(i+1, dec1.size-1)]
        end
    end
end

#puts separDivNum("154", "10")


def divDec(dec1, dec2)
    num, remaind = separDivNum(dec1, dec2)#отделяем цифры пока первое не станет возможным поделить на второе
    temp = (num.to_i/dec2.to_i).to_s#делим отделимый остаток на второе число
    rem2 = num.to_i%dec2.to_i#остаток от деления после отделения цифры и выполенния первого шага деления
    while remaind != ""

        rem2 = (rem2.to_s + remaind[0]).to_i#прибавляем к этому остатку следующее число из делителя для следующей итерации деления
        remaind = remaind.slice(1, remaind.size - 1)# остаток от делителя режем на 1 знак спереди (его забрали на сл цикл строкой выше)
       #rem2, remaind = separDivNum((rem2.to_s + remaind), dec2)
        print "rem2: #{rem2}\n"
        temp = temp + (rem2.to_i/dec2.to_i).to_s
        rem2 = (rem2.to_i%dec2.to_i).to_s
    end
    return [temp, rem2]
end

#print divDec("239212","238")


def addQuantityZero(bin, quan)#эта функция добавляет НУЖНОЕ количество нулей
        for i in 0...quan
            bin = bin + "0"
        end
    return bin
end

#puts addQuantityZero("111", 5)



#puts convertTo16Bit("111010")

def multBin(bin1, bin2)
    summSubTotal = []
    summ = ""
    bin1 = bin1.reverse
    bin2 = bin2.reverse
    for i in 0...bin1.size
        #puts "i: #{i} "
        temp = ""
        for y in 0...bin2.size
            #puts "y: #{y} "
            temp =  ((bin1[i].to_i)*(bin2[y].to_i)).to_s + temp
            #puts temp
        end

        temp = addQuantityZero(temp, i)
        temp = convertTo16Bit(temp)
        #puts temp
        summSubTotal.append(temp)
    end
    if summSubTotal.size == 1
        return summSubTotal[0]
    end
    summ = additionBin(summSubTotal[0], summSubTotal[1])
    if summSubTotal.size > 2
        for i in 2...summSubTotal.size
            summ = additionBin(summ, summSubTotal[i])
        end
    end
    return summ
end

#print multBin("1011", "1101")


def comparisBin(bin1, bin2)
    if bin1.size < bin2.size
	    bin1 = addition0(bin2, bin1)
    elsif bin1.size > bin2.size
	    bin2 = addition0(bin1, bin2)
    end                                 #Нужен этот кусок кода? или у нас всегда 16 бит будет? Или бросить тут исключение?

    for i in 0...(bin1.to_s).size()
        if bin1[i].to_i < bin2[i].to_i
            return -1
        elsif bin1[i].to_i > bin2[i].to_i
            return 1
        end
    end
    return 0
end

#puts comparisBin("111111", "111101")

def separBin(bin1, bin2)
    temp = ""
    for i in 0...bin1.size
        temp = temp + bin1[i]
        if comparisDec(temp, bin2) == 1 || comparisDec(temp, bin2) == 0
            return [temp, bin1.slice(i+1, bin1.size-1)]
        end
    end
end

#print separBin("11111", "11")

def removeZero(bin)
    temp = ""
    for i in 0...bin.size
        if  bin[i] == "1" && i == bin.size-1
            return "1"
        elsif bin[i] == "1"
            temp = bin.slice(i, bin.size-1)
            return temp
        elsif i == bin.size-1  && bin[i] == "0"
            return "0"
        end
    end

end

#print removeZero("000000001001001")

def divBin(bin1, bin2)
    num, remaind = separDivNum(bin1 , bin2)#отделяем цифры пока первое не станет возможным поделить на второе
    #print "remaind: #{remaind}\n"
    #print "num: #{num}\n"
    #print "subBin(num, bin2): #{removeZero(subBin(num,  bin2))}\n"
    if removeZero(subBin(num, bin2)) == "0"
       # print "test \n"
        temp = "1"
    else
        temp = removeZero(subBin(num, bin2))
    end
    #print "temp: #{temp}\n"
    rem2 = removeZero(subBin(num, bin2))#остаток от деления после отделения цифры и выполенния первого шага деления
    #print "rem2: #{rem2}\n"
    #print "removeZero(subBin(num, bin2)): #{removeZero(subBin(num, bin2))}\n"
    while remaind != ""
        #rem2 = (rem2 + remaind[0])#прибавляем к этому остатку следующее число из делителя для следующей итерации деления
        rem2 = (removeZero(rem2) + remaind[0])
        #print "rem2_-_: #{rem2}\n"
        #print "temp_-_: #{temp}\n"
        remaind = remaind.slice(1, remaind.size - 1)# остаток от делителя режем на 1 знак спереди (его забрали на сл цикл строкой выше)

        while comparisBin(rem2, bin2) == -1
            #print "test2 \n"
            if remaind == ""
                remaind = remaind.slice(1, remaind.size - 1)
                rem2 = removeZero(rem2)
                temp = temp + "0"
                return  [temp, rem2]
            end
            rem2 = (removeZero(rem2) + remaind[0])#прибавляем к этому остатку следующее число из делителя для следующей итерации деления
            remaind = remaind.slice(1, remaind.size - 1)
            temp = temp + "0"
            #print "temp-: #{temp}\n"
            #print "rem2-: #{rem2}\n"
        end
        if removeZero(subBin(rem2, bin2)) == "0"
           #print "rem2__: #{rem2}\n"
            rem2 = "0"
            temp =  temp + "1"
            #print "temp__: #{temp}\n"
        else
            rem2 = removeZero(subBin(rem2, bin2))
            #print "rem__: #{rem2}\n"
            temp =  temp + rem2
        end
    end
    return [temp, rem2]
end


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



def addZero(bin, quan)# эта функция конвертирует число в нужное количество бит за счет добавления нолей
    if(quan > bin.size)
        for i in 0...(quan-bin.size)
            bin = bin + "0"
        end
    end
    return bin
end

def dataInstruc()
    sourceCode =File.read("mnemonic")
    #p "sourceCode: #{sourceCode}"
    tempArr = sourceCode.split("\n")
    #print "TemArr: #{tempArr}\n"
    objectFile = ""
    for i in 0...tempArr.size
        if tempArr[i].match(/ORG\s+([0-9]+)/)
            temp = tempArr[i].match(/ORG (.*)/)
            objectFile += addZero(convertDecToBin(temp[1].to_i), 10)+"\n"
        elsif tempArr[i].match(/(DATA\s+)([0-9]+\s*)([,]\s*[0-9]+\s*)/)
            dataArr = tempArr[i].match(/DATA (.*)/)
            dataArr = dataArr[1].split(',')
            #print "TemAr[i]: #{tempArr[i]}\n"
            #print "dataArr: #{dataArr}\n"
            for y in 0...dataArr.size
                objectFile += convertTo16Bit(convertDecToBin(dataArr[y].to_i))+"\n"
            end
        else
            objectFile += assembler(tempArr[i])+"\n"

        end
    end
    ##p objectFile
    File.write('testing', objectFile)
    #return nil
end

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
            #p "operatField: #{operatField}"
            traceRegister(ir, xr, mar, mbr, pc)          #TRACER
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
        traceRegister(ir, xr, mar, mbr, pc)         #TRACER
    end

    #print convertBinToInt(ac)
end


def assembler(mnemText)
    text = mnemText.match(/HALT|([A-Z]+)\s+([=@$]?)([0-9]+)/)
    if !mnemText.match(/HALT|([A-Z]+)\s+([=@$]?)([0-9]+)/)
	    raise "mnemonic assembler text has error"
    end
    if text[0] == "HALT"
        return  "0000000000000000"
    end
    #p text
    command = text[1]
    methodCode = text[2]
    adress = text[3]
    binText = ""
    #p methodCode
    #p command
    case command
        when "LOAD" then binText += "0001"
        when "STORE" then binText += "0010"
        when "CALL" then binText += "0011"
        when "BR" then binText += "0100"
        when "BREQ" then binText += "0101"
        when "BRGE" then binText += "0110"
        when "BRLT" then binText += "0111"
        when "ADD" then binText += "1000"
        when "SUB" then binText += "1001"
        when "MUL" then binText += "1010"
        when "DIV"  then binText += "1011"
        else
    	    #raise "the command in assembler is wrong: #{command}"
    end
    case methodCode
        when "" then binText += "00"
        when "=" then binText += "01"
        when "$" then binText += "10"
        when "@" then binText += "11"
    end
    binText += addition0Param(10,convertDecToBin(adress.to_i))
    return binText

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
#dffsfdвавыаываыввывы

def traceRegister(ir, xr, mar, mbr, pc)
    puts "ir bin: #{ir.slice(0,4).red}#{ir.slice(4,2).green}#{ir.slice(6,10).blue}; ir desAssemb: #{desAssemb(ir)}; xr: #{xr}; mar: #{mar}; mbr: #{mbr}; pc: #{pc}"
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
