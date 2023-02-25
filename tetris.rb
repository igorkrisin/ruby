
require "curses"
include Curses
require 'time'

#p Curses.methods

$count = 0
$live = 3

figure1 = [[0,1,0],
	   			 [0,1,0],
	   			 [0,1,0]]

figure2 = [[0,1,0],
	   			 [0,1,0],
	   			 [0,1,1]]


figure3 = [[0,1,0],
	   			 [0,1,0],
	   			 [1,1,0]]

figure4 = [[0,1,1],
	   			 [0,1,0],
	   			 [1,1,0]]

figure5 = [[1,1,0],
	   			 [0,1,0],
	   			 [0,1,1]]


figure6 = [[1,1,1],
	   			 [0,1,0],
	   			 [0,1,0]]

figure7 = [[1,1,1],
	   			 [1,1,1],
	   			 [1,1,1]]

$figureArr = [figure1,figure2,figure3,figure4,figure5,figure6,figure7, figure7, figure1]

def randomFig(fig)
    return fig[rand(0...fig.size())]
end


def arrayGlass(hight, width)
	glass = []
	for i in 0...hight
		nestedArr=[]
		for y in 0...width
		    nestedArr+=[0]
		end
		glass+=[nestedArr]
	end
	return glass
end


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


def returnGlass(arrayGlass)
	str = ""
	for y in 0...arrayGlass.size()
		for x in 0...arrayGlass[x].size()
			str	+= arrayGlass[y][x].to_s
		end
		str += "\n"
	end
	return str
end


def outInCurses(arrayGl, xStart, yStart)
	for y in 0...arrayGl.size()
		for x in 0...arrayGl[y].size()
			Curses.setpos(yStart+y, xStart+x)
			#Curses.addstr(arrayGl[x][y].to_s)
			if arrayGl[y][x] == 0
			    Curses.addstr(".")
			elsif arrayGl[y][x] == 1
			    Curses.addstr("s")
			end
		end
	end
end

#(Curses.lines - 1) / 2, (Curses.cols - 11) / 2
def dropFigure(figure, figureArr)
    sizeGly = 15
    sizeGlx = 15
    yStart = 0
    xStart = sizeGlx/2
    sizeFigY = 3
    glass = arrayGlass(sizeGly, sizeGlx)
    while(yStart < sizeGly) do

			Curses.setpos(1, 0)
			Curses.addstr("live: ")
			Curses.addstr($live.to_s)

			Curses.setpos(5, 0)
			Curses.addstr("count: ")
			Curses.addstr($count.to_s)

			clearFullLine(glass)
			tempGlass = copyGlass(glass)


			projectFigure(xStart, yStart, glass, figure)
			if check0InY(tempGlass)

				tempGlass = makeNewGlass(glass)
				glass = tempGlass
				$live -= 1
			end

			cbreak
			stdscr.nodelay = 1
			if $live == 0
				Curses.setpos(8, 10)
				Curses.addstr("Game over")
				Curses.timeout = (5000)


				break
			end

			outInCurses(glass,70 ,20)


			case getch
					when ?A, ?a then
				if checkOutOfGlass(yStart, xStart, glass, figure)
						xStart -= 1
						#Curses.addstr(xStart.to_s)
				end
					when ?D, ?d then
				if checkOutOfGlass(yStart, xStart, glass, figure)
						xStart += 1
						#Curses.addstr(xStart.to_s)
				end
				when ?P, ?p then
					sleep(15)
				when ?S, ?s then
					figure = rotationFigure(figure)
			end

			curs_set(0)
			yStart += 1
			sleep(1)

			if(!checkDownNumb(yStart, xStart, tempGlass, figure) && (yStart == sizeGly - sizeFigY+1|| !checkFreePlaceForFig(yStart, xStart, tempGlass, figure)))
					figure = randomFig($figureArr)
					yStart = 0

					next
			elsif(checkDownNumb(yStart, xStart, tempGlass, figure) && (yStart == sizeGly - sizeFigY+2|| !checkFreePlaceForFig(yStart, xStart, tempGlass, figure)))
					figure = randomFig($figureArr)
					yStart = 0

					next
			end

			glass = tempGlass
			#figure = randomFig(figureArr)
		end
end

def makeNewGlass(glass)
	for y in 0...glass.size()
		for x in 0...glass[y].size()
			glass[y][x] = 0
		end
	end
	return glass
end


def check0InY(glass)
	count = 0
	for x in 0...glass[0].size()
		for y in 0...glass.size()
			if glass[y][x] == 0
				count = 0
				break
			else
				count+=1
				#p count
			end
			if count == glass.size()
				return true
			end
		end
	end
	return false
end

def checkDownNumb(yInGlass, xInGlass, glass, figure)
	for y in 2...figure.size()
		for x in 0...figure[y].size()
			if figure[y][x] != 0
				return false
			end
		end
	end
	return true
end


#TODO make left right and list figure random

def copyGlass(glass)
    newGl = []
    for y in 0...glass.size()
			tempArr = []
			for x in 0...glass[y].size()
				tempArr += [glass[y][x]]
			end
			newGl += [tempArr]
    end
    return newGl
end

#print returnGlass(copyGlass(arrayGlass(10,10)))

def projectFigure(xInGlass, yInGlass, glass, figure)
	for y in 0...figure.size()
		for x in 0...figure[y].size()
		    if(figure[y][x] == 0)
					next
		    end
			glass[yInGlass+y][xInGlass+x] = figure[y][x]
		end
	end
	return glass

end

def checkOutOfGlass(yInGlass, xInGlass, glass, figure)
    for y in 0...figure.size()
			for x in 0...figure[y].size()
	    	if  figure[y][x] == 1 && (
					xInGlass+x >= glass[y].size()-1 || yInGlass+y < 0 || xInGlass+x <= 0)
					return false
	    	end
			end
    end
    return true
end

def checkLineFild(glass, numLineY)
  for x in 0...glass[numLineY].size()
		if glass[numLineY][x] == 0
				return false
		end
  end
    return true
end

def shiftDownLine(glass, numLineY)
  for y in (numLineY).downto(0)
		for x in 0...glass[numLineY].size()
			if y-1 >= 0
				glass[y][x] = glass[y-1][x]
			end
		end

  end
	oneToZero(glass, 0)
end

def oneToZero(glass,lineY)
	for x in 0...glass[lineY].size()
		if glass[lineY][x] == 1
			glass[lineY][x] = 0
		end
	end

end

#func for each line if checkLineFild = TRUE then make shiftDownLine

def clearFullLine(glass)
  for y in 0...glass.size()
		if checkLineFild(glass, y)
			shiftDownLine(glass, y)
		end
  end
end
#printGlass(projectFigure(5,5,figure, arrayGlass(10,10)))

def checkFreePlaceForFig(yInGlass, xInGlass, glass, figure)
	for y in 0...figure.size()
		for x in 0...figure[y].size()
		    if(yInGlass+y < glass.size())
					if(glass[yInGlass+y][xInGlass+x] == 1 and figure[y][x] == 1)
							return false
					end
		    end
		end
	end
	return true
end

def rotationFigure(figure)
	figureNew = (0..2).map{Array.new(3)}
	#printFIgure(figureNew)
	s = figure.size()
	for y in 0...s
		for x in 0...s
			figureNew[x][s-y-1] = figure[y][x]
		end
	end
	return figureNew
end

#Curses.addstr(rotationFigure(figure1).to_s)

def printFIgure(fig)
  for x in 0...fig.size()
    p fig[x]
  end
end

#glassArr = projectFigure(5,5,arrayGlass(10,10),figure)

#print returnGlass(glassArr)

#puts checkFreePlaceForFig(5,4,glassArr,figure)

#TODO протестить в glaas check функцию положить туда фигуру , установить ncurses


#!/usr/bin/env rub
#=begin

#__END__

Curses.init_screen


begin

  Curses.crmode
    #outInCurses(projectFigure(5,5,glass,figure), (Curses.lines-1)/4, (Curses.cols - 11)/3)
    #Curses.setpos(15, 15)
    #Curses.addstr(randomFig($figureArr).to_s)
    dropFigure(randomFig($figureArr), $figureArr)
    # Curses.setpos((Curses.lines - 1) / 2, (Curses.cols - 11) / 2)
    # Curses.addstr(printGlass(arrayGlass(10,10)))
    #movementToTheSide(figure)

  Curses.refresh
  Curses.getch

ensure
  Curses.close_screen
end
#=end







