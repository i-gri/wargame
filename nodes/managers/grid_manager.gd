class_name GridManager extends Node

@export var cell_events_bus:CellEventsBus
@export var card_events_bus:CardEventsBus

var grid:Dictionary[Vector2i, Cell] = {}
var map:TileMapLayer

func _ready() -> void:
  cell_events_bus.card_played.connect( _on_card_played )
  card_events_bus.card_selected.connect( _on_card_selected )

func setup( tile_map:TileMapLayer, cells_data:Dictionary[Vector2i, CellCore] ) -> void:
  map = tile_map

  var factory:CellFactory = CellFactory.new()

  for tile:Vector2i in tile_map.get_used_cells():
    var node:Cell = factory.create( tile, map.map_to_local( tile ), cells_data.get(tile, null))

    add_child( node )
    grid[tile] = node


func remove_all_dropzones() -> void:
  for cell:Cell in grid.values():
    cell.remove_dropzone()


func get_cell( tile:Vector2i ) -> Cell:
  return grid.get(tile)


func get_cell_in_position( position:Vector2 ) -> Cell:
  return grid[map.local_to_map( position )]


func get_cells( filter:Callable ) -> Array[Cell]:
  return grid.values().filter( filter )


func _on_card_played( _cell:Cell, _card:Card ) -> void:
  remove_all_dropzones()


func _on_card_selected( card:Card ) -> void:
  # TODO: Add card filters for the cell

  for cell:Cell in get_cells( card.get_filter() ):
    cell.add_card_dropzone()
