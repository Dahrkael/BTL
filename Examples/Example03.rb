require 'rubygems'
require 'gosu'

require 'media/Tilemap.rb'
include Gosu

class Example < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Example 03 of Tilemap class - Zoom"
		@zoom = 1
		@font = Font.new(self, default_font_name(), 22)
		@spriteset = Tilemap.new(self, true)
		@spriteset.load_map("media/map32x32.xml")
	end
	
	def button_down(id)
		case id
			when KbUp
				@zoom += 0.1
			when KbDown
				@zoom -= 0.1
		end
	end
	
	def update
		@spriteset.update(0, 0, @zoom)
	end
	
	def draw
		@font.draw("Use up and down to change zoom", 0, 0, 1)
	end
end

example = Example.new.show