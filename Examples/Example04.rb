require 'rubygems'
require 'gosu'

require 'media/Tilemap.rb'
include Gosu

class Example < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Example 01 of Tilemap class - Different tile size"
		@maps = ["media/map32x32.xml", "media/map48x48.xml"]
		@alternate = false
		@font = Font.new(self, default_font_name(), 22)
		@spriteset = Tilemap.new(self, true)
		@spriteset.load_map("media/map32x32.xml")
	end
	
	def button_down(id)
		case id
			when KbReturn
				case @alternate
					when true
						@spriteset.load_map(@maps[0])
					when false
						@spriteset.load_map(@maps[1])
				end
				@alternate = !@alternate
		end
	end
	
	def update
		@spriteset.update(0, 0)
	end
	
	def draw
		@font.draw("Press Enter to change the map loaded", 0, 0, 1)
	end
end

example = Example.new.show