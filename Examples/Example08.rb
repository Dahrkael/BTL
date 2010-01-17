require 'rubygems'
require 'gosu'

require 'BTL'
include Gosu

class Example < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Example 07 of Tilemap class - Isometric Map Zoom"
		@camera_x = -500
		@camera_y = -200
		@zoom = 0.5
		@font = Font.new(self, default_font_name(), 22)
		@spriteset = BTL::Isometric::Tilemap.new(self, true)
		@spriteset.load_map("media/isometric_map.xml")
	end
	
	def update
		@spriteset.update(@camera_x, @camera_y, @zoom)
	end
	def button_down(id)
		case id
			when KbUp
				@zoom += 0.1
				@camera_x += 50
				@camera_y += 20
			when KbDown
				@zoom -= 0.1
				@camera_x -= 50
				@camera_y -= 20
		end
	end
	
	def draw
		@font.draw("Use Up and Down to change zoom", 0, 0, 1)
	end
end

example = Example.new.show