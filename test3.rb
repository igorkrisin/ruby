
require "curses"
include Curses
require 'time'



#p Curses.methods

$startGlassX = 70
$startGlassY  = 20

$count = 0
$live = 3
$speed = 0.5

$sizeGly = 20
$sizeGlx = 15
$yStart = 0
$xStart = $sizeGlx/2
$sizeFigY = 3

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

figure8 = [[0,1,0],
	   			 [0,1,0],
	   			 [0,1,0]]

figure9 = [[1,1,1],
	   			 [1,1,1],
	   			 [1,1,1]]

$figureArr = [figure1,figure2,figure3,figure4,figure5,figure6,figure7, figure7, figure1, figure1, figure7, figure8, figure9]


def randomFig(fig)
    return fig[rand(0...fig.size())]
end

$figure = randomFig($figureArr)



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


def outInCurses(arrayGl, yStart, xStart)
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
	Curses.refresh
end



def dropFigure()
    cbreak
    stdscr.nodelay = 1
    $glass = arrayGlass($sizeGly, $sizeGlx)

    while($yStart < $sizeGly) do

			Curses.setpos(1, 0)
			Curses.addstr("live: ")
			Curses.addstr($live.to_s)

			Curses.setpos(5, 0)
			Curses.addstr("count: ")
			Curses.addstr($count.to_s)

			clearFullLine($glass)


			if checkGameOver($glass)

				$glass = makeNewGlass($glass)
				$live -= 1
			end

			#cbreak
			#stdscr.nodelay = 1
			if $live == 0
				Curses.setpos(8, 10)
				Curses.addstr("Game over")
				Curses.timeout = (5000)
				break
			end

			sleepTime($speed)


			outInCurses(projectFigure($xStart,$yStart, copyGlass($glass), $figure),$startGlassY ,$startGlassX)
			$yStart += 1
			curs_set(0)



    			    Curses.setpos(35, 45)
    			    Curses.addstr($yStart.to_s)

			#sleep($speed)
			if $count == 10
				$speed -= 0.1#???????????????????? ???????????????? ???????? ?????? ???????????????????? 10 ??????????
			end
			if $count == 100#?????? ???????????????????? 100 ?????????? - ????????????
				Curses.setpos(8, 10)
				Curses.addstr("you win!")
				Curses.timeout = (5000)
				break
			end
			#Curses.timeout = (500)

			if(checkDownNumb($yStart, $xStart, $glass, $figure) && (  $yStart == $sizeGly - $sizeFigY+1 || !checkFreePlaceForFigLise($yStart, $xStart, $glass, $figure) ))
				Curses.setpos(45, 15)#???????????? ????????
				Curses.addstr("fics check")
				$glass = projectFigure($xStart,$yStart, $glass, $figure) # ????????????????
				$figure = randomFig($figureArr)
				$yStart = 0
				$xStart = $sizeGlx/2



			elsif(!checkDownNumb($yStart, $xStart, $glass, $figure) && ($yStart == $sizeGly - $sizeFigY || !checkFreePlaceForFig($yStart, $xStart, $glass, $figure)))
				Curses.setpos(40, 15) #???????????? ????????
				Curses.addstr("fics !check")
        	$glass = projectFigure($xStart,$yStart, $glass, $figure) # ????????????????
        	$figure = randomFig($figureArr)
			    $yStart = 0
			    $xStart = $sizeGlx/2

			end

			#figure = randomFig(figureArr)
		end
end

#TODO ?????????? ???????? ?????????????????????? ?? ?????????????????? ???????? (?????????????? ??????????????????)

def makeNewGlass(glass)
	for y in 0...glass.size()
		for x in 0...glass[y].size()
			glass[y][x] = 0
		end
	end
	return glass
end

def checkGameOver(glass)
  for x in 0...glass[0].size()
    if glass[0][x] == 1
      return true
    end
  end
  return false
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
		Curses.setpos(35, 15)
  	Curses.addstr("true CHDN")
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

def checkOutOfGlassLeft(yInGlass, xInGlass, glass, figure)
  for y in 0...figure.size()
    for x in 0...figure[y].size()
      if  figure[y][x] == 1 && xInGlass+x <= 0
        return false
      end
    end
  end
  return true
end

def checkOutOfGlassRight(yInGlass, xInGlass, glass, figure)
  for y in 0...figure.size()
    for x in 0...figure[y].size()
      if  figure[y][x] == 1 && xInGlass+x >= glass[y].size()-1
        return false
      end
    end
  end
  return true
end

def checkOutOfGlassRightRotat(yInGlass, xInGlass, glass, figure)
  for y in 0...figure.size()
    for x in 0...figure[y].size()
      if  figure[y][x] == 1 && xInGlass+x > glass[y].size()-1
        return false
      end
    end
  end
  return true
end

def checkOutOfGlassLeftRotat(yInGlass, xInGlass, glass, figure)
  for y in 0...figure.size()
    for x in 0...figure[y].size()
      if  figure[y][x] == 1 && xInGlass+x < 0
        return false
      end
    end
  end
  return true
end

def checkOutOfGlassDown(yInGlass, xInGlass, glass, figure)
  for y in 0...figure.size()
    for x in 0...figure[y].size()
      if  figure[y][x] == 1 && yInGlass+y < 0
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
			$count += 1
		end
  end
end
#printGlass(projectFigure(5,5,figure, arrayGlass(10,10)))

def checkFreePlaceForFig(yInGlass, xInGlass, glass, figure)
	for y in 0...figure.size()
		for x in 0...figure[y].size()
		    if(yInGlass+y < glass.size())
				if(glass[yInGlass+y+1][xInGlass+x] == 1 and figure[y][x] == 1)
					Curses.setpos(30, 15)
          Curses.addstr("false")
					return false
				end
		    end
		end
	end
	return true
end

def checkFreePlaceForFigLise(yInGlass, xInGlass, glass, figure)
	for y in 0...figure.size()
		for x in 0...figure[y].size()
		    if(yInGlass+y+1 < glass.size())
				if(glass[yInGlass+y+1][xInGlass+x] == 1 and figure[y][x] == 1)
					Curses.setpos(30, 15)
          Curses.addstr("false")
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

#TODO ?????? ???????????? ?????????????? ???? ???????????????? ?????????????? ?? ???????????????????? ?? ???????????????? ????????????????????

def sleepTime(secFloat)
  timeNow = Time.now.to_f

  count = 0
  while (Time.now.to_f - (timeNow)).round(1) != secFloat

    case getch
    when ?A, ?a then
      if checkOutOfGlassLeft($yStart, $xStart, $glass, $figure)
        $xStart -= 1
        outInCurses(projectFigure($xStart,$yStart, copyGlass($glass), $figure),$startGlassY ,$startGlassX)
      end
    when ?D, ?d then
      if checkOutOfGlassRight($yStart, $xStart,$glass, $figure)
        $xStart += 1
        outInCurses(projectFigure($xStart,$yStart, copyGlass($glass), $figure),$startGlassY ,$startGlassX)
      end

    when ?E, ?e then
      temp =  rotationFigure($figure)

      if checkOutOfGlassRightRotat($yStart, $xStart, $glass, temp) && checkOutOfGlassLeftRotat($yStart, $xStart, $tempGlass, temp)
        $figure = rotationFigure($figure)
	outInCurses(projectFigure($xStart,$yStart, copyGlass($glass), $figure),$startGlassY ,$startGlassX)
      end
     when ?S, ?s then
        break
     end
  end
end

#sleepTime(1, yStart)

#__END__

Curses.init_screen


begin

  Curses.crmode
    #outInCurses(projectFigure(5,5,glass,figure), (Curses.lines-1)/4, (Curses.cols - 11)/3)
    #Curses.setpos(15, 15)
    #Curses.addstr(randomFig($figureArr).to_s)
    dropFigure()
    # Curses.setpos((Curses.lines - 1) / 2, (Curses.cols - 11) / 2)
    # Curses.addstr(printGlass(arrayGlass(10,10)))
    #movementToTheSide(figure)

  Curses.refresh
  Curses.getch

ensure
  Curses.close_screen
end
#=end







