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
			def initialize(window, tilemap, identifier, tile_x, tile_y, r, width, height, z)
				@window = window
				@tilemap = tilemap
				@identifier = identifier
				@zoom = 1
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
				return (@x + @width/2) * @zoom
			end

			def x2
				return (@x + @width) * @zoom
			end
	
			def x3
				return (@x) * @zoom
			end
	
			def x4
				return (@x +@width/2) * @zoom
			end

			def y1
				return (@y) * @zoom
			end

			def y2
				return (@y+@height * (@r/2)) * @zoom
			end
	
			def y3
				return (@y+@height * (@r/2)) * @zoom
			end
	
			def y4
				return (@y+@width * @r) * @zoom
			end

			def tile_x
				return @tile_x
			end
	
			def tile_y
				return @tile_y
			end
	
			def width
				return (@width) * @zoom
			end

			def height
				return (@height) * @zoom
			end
	
			def update(camera_x, camera_y, zoom)
				@zoom = zoom
				@y = (@tile_x + @tile_y) * (@height / 2) * @r - camera_y
				@x = (@tile_x - @tile_y) * (@width / 2) - camera_x
				self.draw
			end
	
			def draw
				# Suelo
				@tilemap.blocks[@identifier][:texture1].draw_as_quad(self.x1, self.y1, 0xffffffff, self.x2, self.y2, 0xffffffff, self.x3, self.y3, 0xffffffff, self.x4, self.y4, 0xffffffff, @z, :default) 
				if @tilemap.blocked == true
					# Pared derecha
					@tilemap.blocks[@identifier][:texture2].draw_as_quad(self.x2, self.y2, 0xffffffff, self.x4, self.y4, 0xffffffff, self.x4, self.y4+(self.height/2.5)+3, 0xff969696, self.x2, self.y2+(self.height/2.5)+3, 0xff969696, @z, :default)
					# Pared izquierda
					@tilemap.blocks[@identifier][:texture3].draw_as_quad(self.x3, self.y3, 0xffffffff, self.x4, self.y4, 0xffffffff, self.x4, self.y4+(self.height/2.5)+3, 0xff969696, self.x3, self.y3+(self.height/2.5)+3, 0xff969696, @z, :default)
				end
			end
	
		end
	end
end
