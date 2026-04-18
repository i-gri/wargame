class_name IsometricCalculator extends Resource


@export var north:Vector2i = Vector2i(0,-1)
@export var south:Vector2i = Vector2i(0,1)
@export var east:Vector2i = Vector2i(1,0)
@export var west:Vector2i = Vector2i(-1,0)


@export var CELL_SIZE = Vector2(20,20)
@export var COORD_OFFSET = Vector2(-30,0)
@export var UNIT_OFFSET = Vector2(0,-1)
@export var a:float =  1 * 10
@export var b:float = -1 * 10
@export var c:float = .5 * 10
@export var d:float = .5 * 10

@export var grid_index_size:Vector2i = Vector2i(4, 4) 

var det = (1 / (a * d - b * c))
var inverted_matrix:Dictionary[String, float] = {
		'a': det * d,
		'b': det * -b,
		'c': det * -c,
		'd': det * a,
}

func position_to_cell( vector:Vector2 ) -> Vector2i:
		return Vector2( ( vector.x + 40 ) * inverted_matrix.get('a') + vector.y * inverted_matrix.get('b'),
																		( vector.x + 40 )* inverted_matrix.get('c') + vector.y * inverted_matrix.get('d'))

func get_cell_position( cell:Vector2i ) -> Vector2:
		return cell.x * Vector2(1,.5) * CELL_SIZE.x/2 + cell.y * Vector2(-1,.5) * CELL_SIZE.y/2 + COORD_OFFSET


func get_cell_position_with_offset( cell:Vector2i ) -> Vector2:
		return get_cell_position( cell ) + UNIT_OFFSET


func generate_grid() -> Dictionary[Vector2i, Pawn]:
		var result:Dictionary[Vector2i, Pawn] = {}

		for x:int in x_range( 0 ):
				for y:int in y_range( 0 ):
						result[Vector2i(x,y)] = null

		return result


func generate_half_grid( direction:Vector2i ) -> Array[Vector2i]:
		var result:Array[Vector2i] = []

		for i:int in x_range( direction.x ):
				for j:int in y_range( direction.y ):
						result.append( Vector2i(i,j))

		return result


func y_range( direction:int ) -> Array:
		var full_range := range( 0, grid_index_size.y * -1, -1 )
		var result:Array = []

		if direction == 0:
				return full_range
		if direction == 1:
			for i:int in grid_index_size.y/2:
				result.append( full_range.pop_front() )

			return result

		for i:int in grid_index_size.y/2:
				result.append( full_range.pop_back() )

		return result
		

func x_range( direction:int ) -> Array:
		var full_range:Array = range( grid_index_size.x )
		var result:Array = []

		if direction == 0:
				return full_range
		if direction == 1:
			for i:int in grid_index_size.x/2:
				result.append( full_range.pop_back() )

			return result

		for i:int in grid_index_size.x/2:
			result.append( full_range.pop_front() )

		return result
