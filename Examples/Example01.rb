require 'rubygems'
require 'gosu'

require 'media/Tilemap.rb'
include Gosu

class Example < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Example 01 of Tilemap class - Loading a map"
		@spriteset = Tilemap.new(self, true)
		@spriteset.load_map("media/map32x32.xml")
	end
	
	def update
		@spriteset.update(0, 0)
	end
end

example = Example.new.show