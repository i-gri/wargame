class_name PawnController extends Node

@export var calculator:IsometricCalculator


func move_units( units:Array[Pawn], origin:Cell, destination:Cell ) -> void:
	var direction:Vector2i = get_direction( origin, destination )
	var new_unit_positions:Array[Vector2] = get_posible_positions( direction, destination )

	for unit:Pawn in units:
		unit.move_to( new_unit_positions.pop_at(randi()%new_unit_positions.size()))


func get_direction( origin:Cell, destination:Cell ) -> Vector2i:
	return Vector2i(0,1)


func get_posible_positions( direction:Vector2i, destination:Cell ) -> Array[Vector2]:
	var result:Array[Vector2] = []

	for quad:Vector2i in calculator.generate_half_grid( direction ):
		result.append( calculator.get_cell_position( quad ) + destination.position )

	return result
