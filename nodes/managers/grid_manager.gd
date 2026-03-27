class_name GridManager extends Node

@export var cell_events_bus:CellEventsBus
@export var card_events_bus:CardEventsBus

var grid:Dictionary[Vector2i, Cell] = {}
var map:TileMapLayer

func _ready() -> void:
  cell_events_bus.card_played.connect( _on_card_played )
  card_events_bus.card_selected.connect( _on_card_selected )

func setup( tile_map:TileMapLayer ) -> void:
  map = tile_map

  var factory:CellFactory = CellFactory.new()

  for tile:Vector2i in tile_map.get_used_cells():
    var node:Cell = factory.create( tile, map.map_to_local( tile ))

    add_child( node )
    grid[tile] = node


func remove_all_dropzones() -> void:
  for cell:Cell in grid.values():
    cell.remove_dropzone()


func get_cell( tile:Vector2i ) -> Cell:
  return grid.get(tile)


func _on_card_played( _cell:Cell, _card:Card ) -> void:
  remove_all_dropzones()


func _on_card_selected( _card:Card ) -> void:
  # TODO: Add card filters for the cell

  get_cell(Vector2i(5,0)).add_card_dropzone()
