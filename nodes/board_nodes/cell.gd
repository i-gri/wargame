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
		

func add_pawn( pawn:Pawn ) -> bool:
	var section:Vector2i = calculator.position_to_section( pawn.position - position )
	
	if sections[section] != null: return false

	return sections.set(section, add_pawn)


func _on_pawn_entered( pawn: Pawn ) -> void:
	# TODO: Make pawn have states that 
	if pawn.is_moving:
		pawn.moved.connect( add_pawn.bind(pawn), CONNECT_ONE_SHOT )
		return

	add_pawn( pawn )

func _on_pawn_exited( pawn: Pawn ) -> void:
	if pawn.moved.is_connected( add_pawn ): pawn.moved.disconnect( add_pawn )

