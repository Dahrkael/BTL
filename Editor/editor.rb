require 'gosu'
require 'Tilemap.rb'
require 'TextField.rb'
require 'Button.rb'
include Gosu

module Colors
	Grey 		= Color.new(255, 150, 150, 150)
	Grey2 	= Color.new(255, 255, 255, 255)
end


class Game_Window < Gosu::Window
	def initialize
		super(800, 600, false)
		self.caption = 'Tilemap Editor'
		@cursor = Image.new(self, "cursor.png", false)
		@font = Font.new(self, default_font_name(), 14)
		
		@text_fields = []
		@buttons = []
		
		@filename_field= TextField.new(self, @font, 15, 15, 100, 16, "File")
		@text_fields << @filename_field
		
		@load_button = Widgets::Button.new(self, @font, 125, 15, 64, 16, "Load")
		@buttons << @button
		
		@tilemap = Tilemap.new(self)
		@tilemap.load_map("mapaxml.xml")
	end
	
	def update
		@tilemap.update(0, 0) if @tilemap.map_loaded == true
		@buttons.find { |bt| 
			if bt.under_point?(mouse_x, mouse_y) 
				bt.active(true)
			else
				bt.active(false)
			end
		}
	end
		
	def button_down(id)
		case id 
			when MsLeft
				self.text_input = @text_fields.find { |tf| tf.under_point?(mouse_x, mouse_y) }
				
				if @buttons[0].under_point?(mouse_x, mouse_y) 
					@tilemap.load_map(@filename_field.text)
				end
		end
	end
	
	def draw
		self.draw_quad(0, 0, Colors::Grey, 800, 0, Colors::Grey, 0, 120, Colors::Grey, 800, 120, Colors::Grey, 0) 
		self.draw_quad(0, 120, Colors::Grey, 160, 120, Colors::Grey, 0, 600, Colors::Grey, 160, 600, Colors::Grey, 0) 
		
		@filename_field.draw
		@button.draw
		
		@cursor.draw(mouse_x, mouse_y, 9999)
	end
	
end

@editor = Game_Window.new.show