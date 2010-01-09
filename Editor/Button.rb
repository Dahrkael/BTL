module Widgets
	class Button
  
		attr_reader :x, :y
  
		def initialize(window, font, x, y, width, height, label="")
			@window = window
			@font = font
			@x = x
			@y = y
			@width = width
			@height = height
			@label = label
			@color = Color.new(255, 180, 180, 180)
		end
  
		def draw
			@window.draw_quad(x-2,    	y-2, 		0xffffffff,
						x + width+2, 	y-2,          	0xffffffff,
						x-2,         	y + height+2, 0xffffffff,
						x + width+2, 	y + height+2, 0xffffffff, 0)
			@window.draw_quad(x,    	y, 		@color,
						x + width, 	y ,          	@color,
						x,         	y + height, @color,
						x + width, 	y + height, @color, 0)
			
			@font.draw(@label, (x+(width/2)) - (@font.text_width(@label)/2), (y+(height/2)) - (@font.height/2), 0, 1, 1, 0xff000000, :default) 
		end

		def width
			@width
		end
  
		def height
			@height
		end
		
		def active(true_or_false)
			case true_or_false
				when true
					@color = Color.new(255, 200, 100, 100)
				when false
					@color = Color.new(255, 180, 180, 180)
			end
		end

		def under_point?(mouse_x, mouse_y)
			mouse_x > x and mouse_x < x + width and
			mouse_y > y and mouse_y < y + height
		end
	end
end