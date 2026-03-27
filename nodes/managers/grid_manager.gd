class_name GridManager extends Node

var grid:Dictionary[Vector2i, Cell] = {}
var map:TileMapLayer

func setup( tile_map:TileMapLayer ) -> void:
  map = tile_map

  var factory:CellFactory = CellFactory.new()

  for tile:Vector2i in tile_map.get_used_cells():
    var node:Cell = factory.create( tile, map.map_to_local( tile ))

    add_child( node )
    grid[tile] = node




