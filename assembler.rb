#file assebler
require './arithmetic'

def dataInstruc()
    sourceCode =File.read("mnemonic")
    #p "sourceCode: #{sourceCode}"
    tempArr = sourceCode.split("\n")
    #print "TemArr: #{tempArr}\n"
    objectFile = ""
    for i in 0...tempArr.size
        if tempArr[i][0] == "#"
            #puts "#"
            next
        elsif  tempArr[i] == ""
            next
        elsif tempArr[i].match(/ORG\s+([0-9]+)/)
            temp = tempArr[i].match(/ORG (.*)/)
            objectFile += addZero(convertDecToBin(temp[1].to_i), 10)+"\n"
        elsif tempArr[i].match(/(DATA\s+)([0-9]+\s*)([,]\s*[0-9]+\s*)/)
            dataArr = tempArr[i].match(/DATA (.*)/)
            dataArr = dataArr[1].split(',')
            print "TemAr[i]: #{tempArr[i]}\n"
            print "dataArr: #{dataArr}\n"
            for y in 0...dataArr.size
                objectFile += convertTo16Bit(convertDecToBin(dataArr[y].to_i))+"\n"
            end
        else
            objectFile += assembler(tempArr[i])+"\n"

        end
    end
    #p objectFile
    File.write('testing', objectFile)
    #return nil
end

def assembler(mnemText)
    text = mnemText.match(/HALT|([A-Z]+)\s+([=@$]?)([0-9]+)/)
    if !mnemText.match(/HALT|([A-Z]+)\s+([=@$]?)([0-9]+)/)
	    raise "mnemonic assembler text has error /#{text}/"
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
        when "DATA" then binText += "0000" #не уверен в правильности данного условия, но на правктике работает
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



dataInstruc()