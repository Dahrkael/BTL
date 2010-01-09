require 'rubygems'
require 'gosu'

require 'Tilemap.rb'
include Gosu

class Example < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Example of Tilemap class"
		@camera_x = 0
		@camera_y = 0
		@zoom = 1
		@spriteset = Tilemap.new(self, true)
		@spriteset.load_map("mapa.xml")
	end
	
	def update
		@spriteset.update(@camera_x, @camera_y)
	end
	
	def button_down(id)
		case id
			when Button::KbDown
			@zoom += 0.1
			when Button::KbUp
			@zoom -= 0.1
		end
	end
	
	def draw
	end
end

example = Example.new.show