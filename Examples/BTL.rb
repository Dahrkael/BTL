require 'Player/Ortogonal/Tilemap'
require 'Player/Isometric/Tilemap'
require 'Player/Isometric/Tile'
module BTL
	Version = 0.2
	Author = "Dahrkael"
	Tilemaps = ["Ortogonal", "Isometric"]
	
	def BTL::check_map_type(filename)
		map = Document.new(File.new(filename))
		map_type = map.elements["map"].elements["type"].text
		BTL::Tilemaps.each { |type|
		return type if map_type == type
		}
		raise "Unkown map type"
	end
end