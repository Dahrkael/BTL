begin
require "rexml/document"
require "gosu"
rescue LoadError
end
include REXML 
include Gosu

class Tilemap
	def initialize(window, tileability)
		@window = window
		@tileability = tileability
		@name = ""
		@description = ""
		@number_of_layers = nil
		@tileset = nil
		@tile = 	{ 
				:width 	=> nil, 
				:height 	=> nil, 
				:size 		=> nil, 
				:nil 		=> "###" 
				}
		@layers = {}
	end
	
	def load_map(filename)
		map = Document.new(File.new(filename))
		@name 			= map.elements["map"].elements["meta"].elements["name"].text
		@description 		= map.elements["map"].elements["meta"].elements["description"].text
		@number_of_layer 	= map.elements["map"].elements["meta"].elements["layers"].text.to_i
		@tileset_filename 	= map.elements["map"].elements["meta"].elements["tileset"].text
		@tile[:width] 		= map.elements["map"].elements["meta"].elements["tile"].elements["width"].text.to_i
		@tile[:height] 		= map.elements["map"].elements["meta"].elements["tile"].elements["height"].text.to_i
		@tile[:size] 		= map.elements["map"].elements["meta"].elements["tile"].elements["size"].text.to_i
		@tile[:nil] 			= map.elements["map"].elements["meta"].elements["tile"].elements["nil"].text
		
		map.elements.each("map/layer") { |layer|
			@layers[layer.elements["name"].text] = {
				:width 	=> layer.elements["width"].text.to_i,
				:height 	=> layer.elements["height"].text.to_i,
				:zorder 	=> layer.elements["zorder"].text.to_i,
				:map 	=> layer.elements["map"].text.gsub!(" ","").split("\n"),
				:tiles 	=> nil
			}
		}
		map = nil
		@layers.each { |current_layer, values|
			@layers[current_layer][:tiles] = Array.new(@layers[current_layer][:width]) do |x|
				Array.new(@layers[current_layer][:height]) do |y|
					case @layers[current_layer][:map][y][x*@tile[:size], @tile[:size]]
						
					when @tile[:nil] 	
						nil
					else
						@layers[current_layer][:map][y][x*@tile[:size], @tile[:size]].to_i
					end #case
				end # y
			end # x
		}
		@tileset = Image.load_tiles(@window, @tileset_filename, @tile[:width], @tile[:height], @tileability)
	end
	
	def update(camera_x, camera_y, zoom=1)
		@layers.each { |current_layer, value|
			max_y = (camera_y + @window.height) / @tile[:height]
			if max_y > @layers[current_layer][:height]-1 then max_y = @layers[current_layer][:height]-1 end
			max_x = (camera_x + @window.width) / @tile[:width]
			if max_x > @layers[current_layer][:width]-1 then max_x = @layers[current_layer][:width]-1 end
			(camera_y/@tile[:height]).upto(max_y) do |y|
				(camera_x/@tile[:width]).upto(max_x) do |x|
					next if x < 0 or y < 0
					next if x * @tile[:width] > camera_x + @window.width
					next if x * @tile[:width] < camera_x - @tile[:width]
					next if y * @tile[:height] > camera_y + @window.height
					next if y * @tile[:height] < camera_y - @tile[:height]
					tile = @layers[current_layer][:tiles][x][y]
					if tile
						@tileset[tile].draw((x * @tile[:width] - camera_x) * zoom, (y * @tile[:height] - camera_y) * zoom, @layers[current_layer][:zorder], zoom, zoom, 0xffffffff, :default) 
					end
				end
			end
		}
	end
	#def solid(x, y)
	#	begin
	#		return true if @layers[1][:tiles][x/@tile[:width]][y/@tile[:height]]
	#	rescue
	#	return false
	#	end
	#end
end



