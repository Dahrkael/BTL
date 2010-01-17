require 'Ortogonal/Tilemap'
require 'Isometric/Tilemap'
require 'Isometric/Tile'
module BTL
	Version = 0.2
	Author = "Dahrkael"
	Tilemaps = ["Ortogonal", "Isometric"]
	
	def BTL::check_map_type(filename)
		map = Document.new(File.new(filename))
		map_type = map.elements["map"].elements["type"].text
		Tilemaps.each { |type|
			if map_type == type
				return type
			else
				raise "Unkown map type"
			end
		}
	end
end