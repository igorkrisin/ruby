

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
#puts additionBin("0100", (addition0("0100", "1")))
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
    temp = additionBin(bin2, addition0(bin2, "1"))#нужно добвать нули что бы слогаемые дылди одного размера лиюбо попрравить функ сложения, тчо бы она правильно скалыдвала числа с разщличным количеством
    puts temp
    summ = additionBin(bin1, temp)
    if(summ.size() > bin1.size())
        summ[0] = ""
    end
    return summ
end

puts subBinNew("111101101", "100100001")


def subBin(bin1, bin2)
    summ = ""
    for i in (bin1.size()-1).downto(0)
        borrow = 0
        y = i
        while bin1[y] == "0"
            y += 1
            if bin1[y] == "0"
                bin1[y] == "1"
            else
                borrow += bin1[y].to_i
                bin1[y] == "1"
            end
        end
        temp = (bin1[i].to_i + borrow) - bin2[i].to_i
        summ = (temp%2).to_s + summ
    end
    return summ
end

#puts subBin("110", "011")

#TODO функция вычитания двух бинарников други из друга только из бОльшего вычитаем меньшее

=begin




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
