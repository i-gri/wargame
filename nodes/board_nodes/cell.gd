class_name Cell extends Area2D

@export var calculator:IsometricCalculator
@export var debug:bool = false


@onready var overlay = $Overlay
@onready var outline = $Outline


var tile:Vector2i
var sections:Dictionary[Vector2i, Pawn]
var dropzone:DropZone


func _ready() -> void:
	$DebugLabels.visible = debug
	sections = calculator.generate_grid()

func get_free_section() -> Vector2i:
	return sections.keys().filter( func( section:Vector2i ) -> bool: return sections[section] == null ).pick_random()
		

func get_section_position( section:Vector2i ) -> Vector2:
	return calculator.get_section_position_with_offset( section ) + position


func add_pawn( pawn:Pawn ) -> bool:
	var section:Vector2i = calculator.position_to_section( pawn.position - position )
	
	if sections.get(section, null) != null: return false

	return sections.set(section, pawn)

func has_player_pawns( player:Player ) -> bool:
	return sections.values().any( _player_owned_pawns.bind( player ) )


func get_player_pawns( player:Player ) -> Array[Pawn]:
	return sections.values().filter( _player_owned_pawns.bind( player ) )


func _on_pawn_entered( pawn: Pawn ) -> void:
	# TODO: Make pawn have states that 
	if pawn.is_moving:
		pawn.moved.connect( add_pawn.bind(pawn), CONNECT_ONE_SHOT )
		return

	add_pawn( pawn )

func _on_pawn_exited( pawn: Pawn ) -> void:
	if pawn.moved.is_connected( add_pawn ): pawn.moved.disconnect( add_pawn )


func _player_owned_pawns( pawn:Pawn, player:Player ) -> bool:
	if pawn == null: return false

	return pawn.player == player 


func _on_mouse_entered() -> void:
	if dropzone == null: return

	outline.visible = true

func _on_mouse_exited() -> void:
	if dropzone == null: return

	outline.visible = false