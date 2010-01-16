require 'rubygems'
require 'gosu'

require 'BTL'
include Gosu

class Example < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Example 06 of Tilemap class - Map Information"
		@camera_x = 0
		@camera_y = 0
		@font = Font.new(self, default_font_name(), 22)
		@spriteset = BTL::Ortogonal::Tilemap.new(self, true)
		@spriteset.load_map("media/map32x32.xml")
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
		@font.draw("Name: " + @spriteset.name, 0, 0, 99)
		@font.draw("Description: " + @spriteset.description, 0, 24, 99)
		@font.draw("Number of layers: " + @spriteset.number_of_layers.to_s, 0, 48, 99)
		@font.draw("Tileset used: " + @spriteset.tileset_filename, 0, 72, 99)
		@font.draw("Tile Info: " + "width: " + @spriteset.tile[:width].to_s + " | height: " + @spriteset.tile[:height].to_s + " | size: " + @spriteset.tile[:size].to_s + " | nil: " + @spriteset.tile[:nil].to_s, 0, 96, 99)
	end
end

example = Example.new.show