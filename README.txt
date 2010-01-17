
###############################################
#                                                                               #
#                    BTL    -    Basic Tilemap Lib                  #
#                                                                               #
#                               MIT License                              #
###############################################

#========================================
# * Description
#========================================

* Library for 2D games developing help in pure ruby.
* Allows tilemaps creation with 2 lines of code, no matter tiles size, layers, etc.
* Only draws in-screen tiles and autofits to window size.
* Maps format in .xml
* Right now only works wih Ruby/Gosu.
* Support for Ortogonal and Isometric maps.

#========================================
# * Usage
#========================================

#---------------------------------------
# * Loading BTL
#---------------------------------------
Because theres no BTL gem you need to paste the files in your project
and then use " require 'path/BTL' "

BTL requires REXML/Document in order to loadmaps

#---------------------------------------
# * Creating the Tilemap
#---------------------------------------
 * Ortogonal view maps

@foo = BTL::Ortogonal::Tilemap.new(window, tileability)

tileability refers to tileability parameter for Gosu::Image, set to true or false.

@foo = BTL::Isometric::Tilemap.new(window, blocked)

blocked lets you choose between plain tiles (top face only)
or block tiles (top, left and right faces)

#---------------------------------------
# * Loading a Map
#---------------------------------------

@foo.load_map(filename)

BTL will check the type defined in the map,
if type is different from the created tilemap type
and error will be raised.
Check function can be called alone:

BTL::check_map_type(filename)

This will return the type, "Ortogonal", "Isometric" or an error.

#---------------------------------------
# * Updating and drawing the Tilemap
#---------------------------------------

@foo.update(camera_x, camera_y, zoom)

#---------------------------------------
# * Examples
#---------------------------------------
Theres some examples to show the basics of the lib

#========================================
# * Maps Structure
#========================================

Maps format uses XML for a clean human-readable structure

Everything is inside <map>
<type> defines map type, supported types are "Ortogonal" and "Isometric"
<meta> contains information about the map
<layers> contains layers information (name, sizes, zorder)
#---------------------------------------
# * Ortogonal Maps
#---------------------------------------
<meta> includes <tileset> tag, which specifies tileset image path, name and format.
<meta><tile> contains tiles width, height, size (number of characters in <layer><map> for each tile)
and nil (character/s in <layer><map> which will be an empty tile)

#---------------------------------------
# * Isometric Maps
#---------------------------------------
<meta> includes <blocks> tag, which contains blocks information (each block is a tile).
<block> contains the 3 textures name used for each block side.
<blocks> has an attribute called textures_folder which specifies textures path.
<block> has an attribute called identifier, which will be used in <layer><map> to create the wanted tile.

<tile> includes an extra tag called <r>, to specify the perspective relation.
<tile><width> and <tile><height> must contain a float, same with <tile><r>

#---------------------------------------
# * Example Maps
#---------------------------------------

You can find example maps in the Examples/media folder. 

#========================================
# * ToDo
#========================================

* Errors control
* Compatibility with other libraries apart Gosu
* Collisions
* Working Editor
* Optional map compression
* Add isometric height maps