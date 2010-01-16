begin
require "gosu"
rescue LoadError
end
include Gosu
module BTL
	module Isometric
		class Tile	
			attr_reader :tile_x
			attr_reader :tile_y
			attr_accessor :z
			attr_accessor :width
			attr_accessor :height
			attr_accessor :r
			def initialize(window, texture1, texture2, texture3, tile_x, tile_y, r, width, height, z)
				@window = window
				@texture1 = Image.new(@window, texture1, true)
				@texture2 = Image.new(@window, texture2, true)
				@texture3 = Image.new(@window, texture3, true)
				@z = z
				@tile_x = tile_x
				@tile_y  = tile_y
				@width = width
				@height = height
				@r = r
				@x = (@tile_x - @tile_y) * (@width / 2)
				@y = (@tile_x + @tile_y) * (@height / 2 ) * @r
			end
	
			def x1
				return @x + @width/2
			end

			def x2
				return @x + @width
			end
	
			def x3
				return @x
			end
	
			def x4
				return @x +@width/2
			end

			def y1
				return @y
			end

			def y2
				return @y+@height * (@r/2)
			end
	
			def y3
				return @y+@height * (@r/2)
			end
	
			def y4
				return @y+@width * @r
			end

			def tile_x
				return @tile_x
			end
	
			def tile_y
				return @tile_y
			end
	
			def width
				return @width 
			end

			def height
				return @height 
			end
	
			def update(camera_x, camera_y)
				@y = (@tile_x + @tile_y) * (@height / 2) * @r - camera_y 
				@x = (@tile_x - @tile_y) * (@width / 2) - camera_x 
				self.draw
			end
	
			def draw
				# Suelo
				@texture1.draw_as_quad(self.x1, self.y1, 0xffffffff, self.x2, self.y2, 0xffffffff, self.x3, self.y3, 0xffffffff, self.x4, self.y4, 0xffffffff, @z, :default) 
				# Pared derecha
				@texture3.draw_as_quad(self.x2, self.y2, 0xffffffff, self.x4, self.y4, 0xffffffff, self.x4, self.y4+(@height/2.5)+3, 0xff969696, self.x2, self.y2+(@height/2.5)+3, 0xff969696, @z, :default)
				# Pared izquierda
				@texture2.draw_as_quad(self.x3, self.y3, 0xffffffff, self.x4, self.y4, 0xffffffff, self.x4, self.y4+(@height/2.5)+3, 0xff969696, self.x3, self.y3+(@height/2.5)+3, 0xff969696, @z, :default)
			end
	
		end
	end
end
