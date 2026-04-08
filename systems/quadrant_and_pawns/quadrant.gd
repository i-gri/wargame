class_name Quadrant extends Area2D

@export var calculator:IsometricCalculator

var cells:Dictionary[Vector2i, Pawn] = {}
var drop_zone:DropZone

func _ready() -> void:
  cells = calculator.generate_grid()


func occupy_cell( pawn:Pawn ) -> void:
  var cell:Vector2i = calculator.position_to_cell( pawn.position - position)
  if cells.has(cell):
    cell = get_random_cell()

  cells[cell] = pawn
  pawn.position = calculator.get_cell_position_with_offset( cell ) + position


func get_free_cells() -> Array[Vector2i]:
  var result:Array[Vector2i] = []

  for key:Vector2i in cells.keys():
    if cells[key] != null: continue

    result.append( key )

  return result


func get_random_cell() -> Vector2i:
  return cells.keys().pick_random()


func add_snap_dropzone( dropzone:DropZone, cell_ids:Array[Vector2i] ) -> void:
  drop_zone = dropzone

  drop_zone.drop_applied.connect( _on_unit_dropped )

  for cell:Vector2i in cell_ids:
    var cell_pos:Vector2 = calculator.get_cell_position_with_offset( cell )

    var mark:Marker2D = Marker2D.new()
    mark.position = cell_pos

    drop_zone.add_child( mark )
  
  add_child( drop_zone )


# expects pawns to be on Layer 1
func _on_pawn_exited(pawn: Pawn) -> void:
  if drop_zone: return  


func _on_pawn_entered(pawn: Pawn) -> void:
  if drop_zone: return

  occupy_cell( pawn )


func _on_unit_dropped( _dropzone:DropZone, unit:Area2D, _plan:DropPlan ) -> void:
  pass