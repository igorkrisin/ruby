

def convertDecToBin(dec)

    summ = ""
    while dec != 0 && dec !=1
	    summ = (dec%2).to_s + summ
	    dec = dec/2
    end
    summ = dec.to_s + summ

end


#puts convertDecToBin(458)


def convertBinToDec(bin)
    summ = 0
    bin = bin.reverse
    for n in 0...bin.size()
	if(bin[n] == "1")
	    summ += (bin[n]).to_i * 2 ** n
	end
    end
    return summ
end

#puts convertBinToDec("111001010")

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
    while bin1.size() != bin2.size()
        bin2 = "0" + bin2
    end
    return bin2
end
#puts additionBin("1010", "1010")
#puts addition0("010101", "1")

def subBinNew(bin1, bin2)

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
    puts temp
    summ = additionBin(bin1, temp)
    if(summ.size() > bin1.size())
        summ[0] = ""
    end
    return summ
end

#puts subBinNew("111101101", "100100001")


def subBin(bin1, bin2)
    summ = ""
    borrow = 0
    for i in (bin1.size()-1).downto(0)
        temp = (bin1[i].to_i - borrow) - bin2[i].to_i
        if temp == 0 || temp == 1
            #puts temp
            summ = temp.to_s + summ
            borrow = 0
            #puts summ
        else
            #puts "---1"
            borrow = 1
    	    summ = "1" + summ

        end
    end
    return summ
end
#puts  subBin("1101001", "0110001")



#TODO функция вычитания двух бинарников други из друга только из бОльшего вычитаем меньшее

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
    #puts temp
    #puts remaind
    rem2 = num.to_i%dec2.to_i#остаток от деления после отделения цифры и выполенния первого шага деления
    while remaind != ""
       # puts "test"
        rem2 = (rem2.to_s + remaind[0]).to_i#прибавляем к этому остатку следующее число из делителя для следующей итерации деления
        remaind = remaind.slice(1, remaind.size - 1)# остаток от делителя режем на 1 знак спереди (его забрали на сл цикл строкой выше)
        temp = temp + (rem2/dec2.to_i).to_s
    end
    return temp
    #TODO доделать деление десятичное, бинарное  сделать умножение и попробовать сделать бинарное деление)
end

#puts divDec("1000","25")


def addQuantityZero(bin, quan)
    for i in 0...quan
        bin = bin + "0"
    end
    return bin
end

#puts addQuantityZero("111", 5)

def convertTo16Bit(bin)
    for i in 0...(16-bin.size)
        bin = "0" + bin
    end
    return bin
end

#puts convertTo16Bit("111010")
#(4).downto(1)
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

print multBin("1011", "1101")


#puts "mult: \n"

#puts additionBin(additionBin(multBin("101", "110")[0], multBin("101", "110")[1]), multBin("101", "110")[2])
#нужно теперь добавить в функцию multBin логику складывания всех промежуточных итогов - сначала складывакем первый со вторым, потом второй с третьим
# и так далее за счет цикла (пример без цикла в 327 сторке)

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
