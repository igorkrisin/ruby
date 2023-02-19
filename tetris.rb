
require "curses"
include Curses
require 'time'



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

$figureArr = [figure1,figure2,figure3,figure4,figure5,figure6] 

def randomFig(fig)
    return fig[rand(0..5)]
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

def returnGlass(arrayGlass)
	str = ""
	for i in 0...arrayGlass.size()	
		for y in 0...arrayGlass[i].size()
			str	+= arrayGlass[i][y].to_s
		end
		str += "\n"
	end
	return str
end


def outInCurses(arrayGl, xStart, yStart)
	for y in 0...arrayGl.size()
		for x in 0...arrayGl[y].size()		
			Curses.setpos(xStart+x, yStart+y)
			#Curses.addstr(y.to_s)
			Curses.addstr(arrayGl[x][y].to_s)
		end
	end
end
				
	
#printGlass(arrayGlass(10,10))


#TODO MAKE DROP FIGURE

def movementToTheSide(figure)
    sizeGly = 10
    sizeGlx = 10
    yStart = 0
    xStart = 4
    sizeFigY = 3
    glass = arrayGlass(sizeGly, sizeGlx)
    while( xStart >= 0) do
	stdscr.keypad = true 
	tempGlass = copyGlass(glass)
	projectFigure(xStart, yStart, glass, figure)
	outInCurses(glass,sizeGlx, sizeGly)
	move = getch
	if(move == KEY_LEFT)
	    xStart -= 1
	end
	if(move == KEY_RIGHT)
	    xStart += 1
	    
	end
	if(xStart >= sizeGlx)
	    xStart = sizeGlx
	    next
	end
	if(xStart <= 0)
	    xStart = 0
	    next
	end
	
	glass = tempGlass
    end

end


def dropFigure(figure, figureArr)
    sizeGly = 10
    sizeGlx = 10
    yStart = 0
    xStart = 5
    sizeFigY = 3
    
    #stdscr.nodelay  = 1
    glass = arrayGlass(sizeGly, sizeGlx)
    while( yStart < sizeGly) do
	tempGlass = copyGlass(glass)
	
	projectFigure(xStart, yStart, glass, figure)
	outInCurses(glass,5 ,5)

	cbreak
	stdscr.nodelay = 1
	sleep(1)
	getch
	
	curs_set(0)
	#curs_set(0)
	yStart += 1
	if(yStart == sizeGly - sizeFigY+1 || !checkFreePlaceForFig(yStart, xStart, glass, figure))
	    figure = randomFig($figureArr)
	    yStart = 0
	    
	    #figure = randomFig(figureArr)
	    next
	end
	glass = tempGlass
	#figure = randomFig(figureArr)
    end
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
	for x in 0...figure.size()
		for y in 0...figure[x].size() 
			glass[yInGlass+y][xInGlass+x] = figure[y][x]
		end
	end
	return glass
	
end




#printGlass(projectFigure(5,5,figure, arrayGlass(10,10)))

def checkFreePlaceForFig(yInGlass, xInGlass, glass, figure)
	#for y in 0...figure.size()
		for x in 0...figure[0].size()
		    if(yInGlass+figure.size()+1 < glass.size())
			if(glass[yInGlass+2][xInGlass+x] == 1 and figure[-1][x] == 1)
				return false
			end
		    end
		end
	#end
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
    Curses.addstr(randomFig($figureArr).to_s)
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
