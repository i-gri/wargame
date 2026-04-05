class_name IsometricCalculator extends Resource

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

  for x:int in range( grid_index_size.x ):
    for y:int in range( 0, grid_index_size.y * -1, -1 ):
      result[Vector2i(x,y)] = null

  return result
