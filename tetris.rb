

figure = [[0,1,0],
		  [0,1,0],
		  [0,1,1]]

# first example

def arrayGlass(hight, width)
	glass = []
	for i in 0...hight
		nestedArr=[]
		for	y in 0...width
			nestedArr+=[0]
		end
		glass+=[nestedArr]
	end
	return glass
end

#p arrayGlass(10,10)


def arrayGlass(hight, width)
	glass = []
	for i in 0...hight
		
		nestedArr=[]

		glass+=[nestedArr]
		for	y in 0...width
			nestedArr.push(0)
		end
		
	end
	return glass
end

def printGlass(arrayGlass)
	for i in 0...arrayGlass.size()	
		for y in 0...arrayGlass[i].size()
			print arrayGlass[i][y]
		end
		print"\n"
	end
end

#printGlass(arrayGlass(10,10))


	
def projectFigure(xGlass, yGlass, glass, figure)
	for y in 0...figure.size()
		for x in 0...figure[y].size() 
			glass[yGlass+y][xGlass+x] = figure[y][x]
		end
	end
	return glass
	
end

#printGlass(projectFigure(5,5,figure, arrayGlass(10,10)))

def checkFreePlaceForFig(yGlass, xGlass, glass, figure)
	for y in 0...figure.size()
		for x in 0...figure[y].size()
			if(glass[yGlass+y][xGlass+x] == 1 and figure[y][x] == 1)
				return false
			end
		end
	end
	return true
end


def rotationFigure(figure)
	figureNew = (0..2).map{Array.new(3)}
	#printFIgure(figureNew)
	s = figure.size()
	#p s
	for y in 0...s
		for x in 0...s
			#p s-y+1
			figureNew[x][s-y-1] = figure[y][x]
		end
	end
	return figureNew
end

def printFIgure(fig)
	
		for x in 0...fig.size()
			p fig[x]
		end
		
	
end

p "фигура сначала: "
printFIgure(figure)
print "\n"
print "фигура перевернутая: "
print"\n"
printFIgure(rotationFigure(figure))

#glassArr = projectFigure(5,5,arrayGlass(10,10),figure)

#printGlass(glassArr)

#puts checkFreePlaceForFig(5,4,glassArr,figure)

#TODO протестить в glaas check функцию положить туда фигуру , установить ncurses

