#file assebler
require './arithmetic'

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
#TODO disass->CPU.rb  dataInstruct->CPU.rb

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
        when "DATA" then binText += "0000" 
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
    	    raise "the command in assembler is wrong: #{command}"
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



#dffsfdвавыаываыввывы



dataInstruc()