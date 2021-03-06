begin
require "rexml/document"
require "gosu"
rescue LoadError
end
include REXML 
include Gosu
module BTL
	module Isometric
		class Tilemap
			attr_reader :blocked
			attr_reader :name
			attr_reader :description
			attr_reader :number_of_layers
			attr_reader :tile
			attr_reader :tileability
			attr_reader :blocks
			attr_reader :layers
			def initialize(window, blocked=true)
				@window = window
				@blocked = blocked
				@name = ""
				@description = ""
				@number_of_layers = nil
				@tile = 	{ 
						:width 	=> nil, 
						:height 	=> nil, 
						:r		=> nil,
						:size 		=> nil, 
						:nil 		=> "###" 
						}
				@blocks = {}
				@layers = {}
			end
			
			def load_map(filename)
				raise "Map type is not isometric" if BTL::check_map_type(filename) != "Isometric"
				map = Document.new(File.new(filename))
				@name 			= map.elements["map"].elements["meta"].elements["name"].text
				@description 		= map.elements["map"].elements["meta"].elements["description"].text
				@number_of_layers 	= map.elements["map"].elements["meta"].elements["layers"].text.to_i
				@tile[:width] 		= map.elements["map"].elements["meta"].elements["tile"].elements["width"].text.to_i
				@tile[:height] 		= map.elements["map"].elements["meta"].elements["tile"].elements["height"].text.to_i
				@tile[:r] 			= eval(map.elements["map"].elements["meta"].elements["tile"].elements["r"].text)
				@tile[:size] 		= map.elements["map"].elements["meta"].elements["tile"].elements["size"].text.to_i
				@tile[:nil] 			= map.elements["map"].elements["meta"].elements["tile"].elements["nil"].text
				@blocks[:folder] 		= map.elements["map"].elements["meta"].elements["blocks"].attributes["textures_folder"]
				
				if @blocked == true
					map.elements.each("map/meta/blocks/block") { |block|
						@blocks[block.attributes["identifier"]] = {
							:left 		=> block.elements["left"].text,
							:right 	=> block.elements["right"].text,
							:top 		=> block.elements["top"].text,
							:texture1	=> Image.new(@window, @blocks[:folder]+"/"+block.elements["top"].text, true),
							:texture2	=> Image.new(@window, @blocks[:folder]+"/"+block.elements["right"].text, true),
							:texture3	=> Image.new(@window, @blocks[:folder]+"/"+block.elements["left"].text, true)
						}
					}
				else
					map.elements.each("map/meta/blocks/block") { |block|
						@blocks[block.attributes["identifier"]] = {
							:top 		=> block.elements["top"].text,
							:texture1	=> Image.new(@window, @blocks[:folder]+"/"+block.elements["top"].text, true)
						}
					}
				end
		
				map.elements.each("map/layers/layer") { |layer|
					@layers[layer.elements["name"].text] = {
						:width 	=> layer.elements["width"].text.to_i,
						:height 	=> layer.elements["height"].text.to_i,
						:zorder 	=> layer.elements["zorder"].text.to_i,
						:order	=> layer.elements["order"].text.to_i,
						:map 	=> layer.elements["map"].text.gsub!(" ","").split("\n"),
						:tiles 	=> nil
					}
				}
		
				map = nil
		
				@layers.each { |current_layer, values|
					@layers[current_layer][:tiles] = Array.new(@layers[current_layer][:height]) do |y|
						Array.new(@layers[current_layer][:width]) do |x|
							nil
						end # y
					end # x
				}
				@layers.each { |current_layer, values|
					@layers[current_layer][:height].times do |y|
						@layers[current_layer][:width].times do |x|
							case @layers[current_layer][:map][y][x*@tile[:size], @tile[:size]]
						
							when @tile[:nil] 	
								@layers[current_layer][:map][y][x*@tile[:size], @tile[:size]] = nil
							else
								@blocks.each { |identifier, value|
									if @layers[current_layer][:map][y][x*@tile[:size], @tile[:size]] == identifier
										@layers[current_layer][:tiles][y][x*@tile[:size], @tile[:size]] = BTL::Isometric::Tile.new(@window, self, identifier, @layers[current_layer][:order], x, y, @tile[:r], @tile[:width], @tile[:height], @layers[current_layer][:zorder])
									end
								}
							end #case
						end # y
					end # x
				}
			end
	
			def update(camera_x, camera_y, zoom=1)
				@layers.each { |current_layer, value|
					@layers[current_layer][:height].times do |y|
						@layers[current_layer][:width].times do |x|
							tile = @layers[current_layer][:tiles][y][x]
							if tile 
								tile.update(camera_x, camera_y, zoom)
							end
						end
					end
				}
			end

		end
	end
end
