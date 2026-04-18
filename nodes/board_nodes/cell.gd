class_name Cell extends Area2D

@export var calculator:IsometricCalculator
@export var debug:bool = false

var tile:Vector2i
var sections:Dictionary[Vector2i, Pawn]

func _ready() -> void:
	$DebugLabels.visible = debug
	sections = calculator.generate_grid()

func get_free_section() -> void:
	return sections.keys().filter( func( section:Vector2i ) -> bool: return sections[section] == null ).pick_random()
		


func _on_pawn_entered( pawn: Pawn ) -> void:
	# TODO: Make pawn have states that 
	if pawn.is_moving():
		pawn.moved.connect( pawn_occupied_space.bind(pawn))
	var section:Vector2i = calculator.get_position_to_section( pawn.position )
	sections[]
	pawns.append( pawn )

func _on_pawn_exited( pawn: Pawn ) -> void:
	pawns.erase( pawn )

