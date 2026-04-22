class_name PlayerController extends Node

@export var grid:Grid
@export var pawn_manager:PanwManager
@export var pawn_controller:PawnController
@export var player:Player

var selected_cell:Cell
var target_cell:Cell
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_grid()


func set_grid() -> void:
	if grid == null: return

	grid.cell_selected.connect( _on_cell_selected )



func _on_cell_selected( cell:Cell ) -> void:
	print_debug("selected: ", cell.tile )
	if selected_cell == null:
		if cell.has_player_pawns( player ):
			print_debug('is it here: ', cell.sections.values())
			selected_cell = cell
		else:
			var section:Vector2i = cell.get_free_section()
			print_debug("section: ", section )

			pawn_manager.deploy_unit( cell.get_section_position( section ), player )

	else:
		target_cell = cell
		pawn_controller.move_units( selected_cell.get_player_pawns( player ), selected_cell, target_cell )

	
