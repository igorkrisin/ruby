require 'ruby2d'

set title: "Tetris"
set fps_cap: 2
set vsync: true


GRID_SIZE = 40
WIDTH = 10
HEIGHT = 15
GRID_COLOR = Color.new('#222222')
BLOCK_COLOR = Color.new(['orange', 'yellow', 'green'].sample)

set width: WIDTH * GRID_SIZE
set height: HEIGHT * GRID_SIZE

(0..Window.width).step(GRID_SIZE).each do |x|
	Line.new(x1: x, x2: x, y1: 0, y2: Window.height, width: 2, color: GRID_COLOR)
end

(0..Window.height).step(GRID_SIZE).each do |y|
	Line.new(y1: y, y2: y, x1: 0, x2: Window.width, width: 2, color: GRID_COLOR)
end

current_line = 1

#figure = [[0,1],[1,1],[1,2],[2,1]]
figure = [[1,0],[1,1],[1,2],[0,1]]
figure2 = [[1,0],[2,0],[3,0],[4,0]]
figure3 = [[1,0],[2,0],[1,1],[1,2]]
figure4 = [[1,0],[2,0],[1,1],[2,1]]


def rightBoundryFigure(figure)
	max = 0
	for y in 0...figure.size()
		if figure[y][1] > max
			max = figure[y][1]
		end
	end
	return max+1
end

def downBoundryFigure(figure)
	max = 0
	for y in 0...figure.size()
		if figure[y][0] > max
			max = figure[y][1]
		end
	end
	return max
end

#rightBoundryFigure(figure)

#figures = [figure, figure2, figure3, figure4].sample

def drawOneSq(yy,xx, grid_size, yStart, xStart)
	Square.new(
		y: (yy+yStart-1)*GRID_SIZE,
		x: (xx+xStart)*GRID_SIZE,
		size: GRID_SIZE,
		color: BLOCK_COLOR,
	)
end

#drawOneSq(figure[1][1],figure[1][0], GRID_SIZE)

def mainDraw(fig,yStart, xStart)
	j = 0
	for i in 0...fig.size()
			drawOneSq(fig[i][j],fig[i][j+1],GRID_SIZE,yStart,xStart)
	end
end

#mainDraw(figures,3,4)

def move(figures, yPos, xPos)
	mainDraw(figures, yPos, xPos)
	update do
		if yPos < HEIGHT - downBoundryFigure(figures)
			#puts  HEIGHT - downBoundryFigure(figures)
			#puts yPos
			clear
			yPos += 1
			mainDraw(figures, yPos, xPos)

			if yPos == (HEIGHT - downBoundryFigure(figures))
				yPos = 0
				mainDraw(figures, yPos, xPos)
				#puts yPos
				#puts xPos
			end
			mainDraw(figures, yPos, xPos)
		end
	end
	on :key_down do |event|
		if event.key == 'left'
			if xPos > 0
				clear
				xPos -= 1
			end
			mainDraw(figures, yPos, xPos)
		elsif event.key == 'right'
			if xPos < WIDTH - rightBoundryFigure(figures)
				clear
				xPos += 1
			end
			mainDraw(figures, yPos, xPos)
		end
	end




end


move(figure,0,0)
		#update do
def mainLoop(figures)


	#while (yStart < (400)) do
		mainDraw(figures, yStart, xStart)
		move(figures, yStart, xStart)
			#yStart += 5
			#mainDraw(figures, yStart, xStart)
		#end
	#end
end

#mainLoop(figures)





show
=begin Square.new(

	x: 0*GRID_SIZE,
	y: 0*GRID_SIZE,
	size: GRID_SIZE,
	color: BLOCK_COLOR,
)

Square.new(

	x: 1*GRID_SIZE,
	y: 0*GRID_SIZE,
	size: GRID_SIZE,
	color: BLOCK_COLOR,
)

Square.new(

	x: 2*GRID_SIZE,
	y: 0*GRID_SIZE,
	size: GRID_SIZE,
	color: BLOCK_COLOR,
)

Square.new(

	x: 1*GRID_SIZE,
	y: 1*GRID_SIZE,
	size: GRID_SIZE,
	color: BLOCK_COLOR,
) =end


=begin Square.new(
	x:0,
	y: 0,
	size: GRID_SIZE,
	color: BLOCK_COLOR

) =end


=begin
Square.new(
	x:2*GRID_SIZE,
	y: 2*GRID_SIZE,
	size: GRID_SIZE,
	color: BLOCK_COLOR

)
=end
#=begin
=begin for y in 0...figure.size()
	for x in 0...figure[y].size()
		Square.new(

			x: figure[y][x]*GRID_SIZE,
			y: figure[y][x]*GRID_SIZE,
			size: GRID_SIZE,
			color: BLOCK_COLOR,
		)
	end
end =end
=begin
active_squares = (0..3).map do |index|
	Square.new(
		x:GRID_SIZE*index,
		y: GRID_SIZE * current_line,
		size: GRID_SIZE,
		color: BLOCK_COLOR

	)
end
=end
#Quad.new



=begin
rect = Rectangle.new(
  x: 125, y: 250,
  width: 200, height: 100,
  color: 'teal',
  z: 20
)

Text.new(
	'My ruby game tetris',
	x: 80,
	y: 10,
	size: 35,
	color: 'white'

)

on :key_held do |event|
	case event.key
		when 'up'
			if rect.y > 0
				rect.y -=5
			end
		when 'down'
			if rect.y < (get :height)-100
				rect.y +=5
			end
		when 'right'
			if rect.x < (get :width)-200
				rect.x +=5
			end
		when 'left'
			if rect.x > 0
				rect.x -=5
			end

		end
	end





show
=end
