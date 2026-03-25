class_name Cell extends Node2D

const CELL_SIZE = Vector2(20,20)
const COORD_OFFSET = Vector2(-30,0)

const ALLOWED_TILES:Dictionary[Vector2i, Array] = {
  Vector2i(0,1): [Vector2i(0,0), Vector2i(1,0), Vector2i(2,0), Vector2i(3,0)],
  Vector2i(0,-1): [Vector2i(0,-3), Vector2i(1,-3), Vector2i(2,-3), Vector2i(3,-3)],
  Vector2i(1,0): [Vector2i(3,0), Vector2i(3,-1), Vector2i(3,-2), Vector2i(3,-3)],
  Vector2i(-1,0): [Vector2i(0,0), Vector2i(0,-1), Vector2i(0,-2), Vector2i(0,-3)],
}


var occupied_tiles:Dictionary[Vector2i, Unit] = {}

func _ready():
  print_debug('cell')


func calculate_tile_to_position( tile:Vector2i ) -> Vector2:
  return tile.x * Vector2(1,.5) * CELL_SIZE.x/2 + tile.y * Vector2(-1,.5) * CELL_SIZE.y/2 + COORD_OFFSET


func _on_area_exited(area: Area2D) -> void:
  pass # Replace with function body.

func _on_area_entered(area: Area2D) -> void:
  print_debug('COCL')
  on_unit_entered( area )


func get_available_spaces() -> Array[Vector2i]:
  var available:Array[Vector2i] = [] 
  for tile:Vector2i in ALLOWED_TILES[Vector2i(0,1)]:
    if occupied_tiles.has(tile): continue

    available.append( tile )

  return available


func on_unit_entered( area:Area2D ) -> void:
  print_debug("entered")
  var available := get_available_spaces()

  if available.is_empty(): return

  var tile:Vector2i = available.pick_random()

  var unit:Unit = area.get_parent()

  unit.position = global_position + calculate_tile_to_position( tile )
  occupied_tiles[tile] = unit



  