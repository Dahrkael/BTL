require 'rubygems'
require 'gosu'

require 'media/Tilemap.rb'
include Gosu

class Example < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Example 05 of Tilemap class - Multilayer Map"
		@camera_x = 0
		@camera_y = 0
		@font = Font.new(self, default_font_name(), 22)
		@spriteset = Tilemap.new(self, true)
		@spriteset.load_map("media/map2.xml")
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
		@font.draw("This map has 3 layers", 0, 0, 99)
	end
end

example = Example.new.show