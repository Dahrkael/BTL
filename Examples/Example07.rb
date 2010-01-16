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
		@font = Font.new(self, default_font_name(), 22)
		@spriteset = BTL::Isometric::Tilemap.new(self)
		@spriteset.load_map("media/isomap.xml")
	end
	
	def update
		@spriteset.update(@camera_x, @camera_y)
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
	
	def draw
		@font.draw("Use arrows to move the camera around the map", 0, 0, 1)
	end
end

example = Example.new.show