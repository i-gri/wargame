class_name PlayerController extends Node

@export var grid:Grid
@export var pawn_manager:PanwManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  set_grid()


func set_grid() -> void:
  if grid == null: return

  grid.cell_selected.connect( _on_cell_selected )



func _on_cell_selected( cell:Cell ) -> void:
  var position:Vector2 = cell.get_free_