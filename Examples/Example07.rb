require 'rubygems'
require 'gosu'

require 'BTL'
include Gosu

class Example < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Example 07 of Tilemap class - Isometric Map"
		@camera_x = 0
		@camera_y = 0
		@block_mode = false
		@font = Font.new(self, default_font_name(), 22)
		load_tilemap
	end
	
	def load_tilemap
		@spriteset = BTL::Isometric::Tilemap.new(self, @block_mode)
		@spriteset.load_map("media/isomap.xml")
		@block_mode = !@block_mode
	end
	
	def update
		@spriteset.update(@camera_x, @camera_y, 0.5)
		if self.button_down?(KbLeft)
			@camera_x -= 10
		end
		if self.button_down?(KbRight)
			@camera_x += 10
		end
		if self.button_down?(KbUp)
			@camera_y -= 10
		end
		if self.button_down?(KbDown)
			@camera_y += 10
		end
	end
	def button_down(id)
		case id
			when KbReturn
				load_tilemap
		end
	end
	
	def draw
		@font.draw("Use arrows to move the camera around the map", 0, 0, 1)
		@font.draw("Use enter to reload the map with/out blocked mode", 0, 22, 1)
	end
end

example = Example.new.show