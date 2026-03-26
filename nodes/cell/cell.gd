class_name Cell extends Area2D

const CELL_SIZE = Vector2(20,20)
const COORD_OFFSET = Vector2(-30,0)
const UNIT_OFFSET = Vector2(0,-1) # Not used currently
const HIGHLIGHT_SEGMENT_ID = "uid://bxv0ntbyhlhiq"

const ALLOWED_TILES:Dictionary[Vector2i, Array] = {
  Vector2i(0,1): [Vector2i(0,0), Vector2i(1,0), Vector2i(2,0), Vector2i(3,0)],
  Vector2i(0,-1): [Vector2i(0,-3), Vector2i(1,-3), Vector2i(2,-3), Vector2i(3,-3)],
  Vector2i(1,0): [Vector2i(3,0), Vector2i(3,-1), Vector2i(3,-2), Vector2i(3,-3)],
  Vector2i(-1,0): [Vector2i(0,0), Vector2i(0,-1), Vector2i(0,-2), Vector2i(0,-3)],
}


var occupied_tiles:Dictionary[Vector2i, Unit] = {}

@onready var highlights:CanvasGroup = $Highlights


func _ready():
  pass
  

func calculate_tile_to_position( tile:Vector2i ) -> Vector2:
  return tile.x * Vector2(1,.5) * CELL_SIZE.x/2 + tile.y * Vector2(-1,.5) * CELL_SIZE.y/2 + COORD_OFFSET


func calculate_position_to_tile( unit_position:Vector2 ) -> Vector2i:
  const a:float =  1 * 10
  const b:float = -1 * 10
  const c:float = .5 * 10
  const d:float = .5 * 10

  const det = (1 / (a * d - b * c));
  const inverted_matrix:Dictionary[String, float] = {
    'a': det * d,
    'b': det * -b,
    'c': det * -c,
    'd': det * a,
  }

  return Vector2( ( unit_position.x + 40 ) * inverted_matrix.get('a') + unit_position.y * inverted_matrix.get('b'),
                  ( unit_position.x + 40 )* inverted_matrix.get('c') + unit_position.y * inverted_matrix.get('d'))



func add_dropzone( snap_positions:Array[Vector2] ) -> void:
  var dropzone:DropZone = DropZone.new()
  dropzone.attach_spot = self
  dropzone.drop_behavior = DropBehaviorReject.new()
  dropzone.snap_style = dropzone.SNAP_STYLE.SNAP_MARKERS

  dropzone.drop_applied.connect( _on_unit_entered )

  for snap_position:Vector2i in snap_positions:
    var mark:Marker2D = Marker2D.new()
    var sprite:Sprite2D = load(HIGHLIGHT_SEGMENT_ID).instantiate()
    var segment_position = snap_position # calculate_tile_to_position( space )

    sprite.position = segment_position
    mark.position = segment_position

    highlights.add_child(sprite)
    dropzone.add_child( mark )

  add_child( dropzone )


func get_available_spaces( entry_point:Vector2i ) -> Array[Vector2i]:
  var available:Array[Vector2i] = [] 
  for tile:Vector2i in ALLOWED_TILES[entry_point]:
    if occupied_tiles.has(tile): continue

    available.append( tile )

  return available


func _on_unit_entered( _dropzone:DropZone, unit:Area2D, _plan:DropPlan ) -> void:
  print_debug("entered")

  var tile = calculate_position_to_tile( unit.position )
  add_unit( unit, tile)


func add_unit( unit:Unit, tile:Vector2i ) -> void:
  occupied_tiles[tile] = unit


func get_all_segments() -> Array[Vector2i]:
  var result:Array[Vector2i] = []
  for x in 4:
    for y in 4:
      result.append( Vector2i( x,y * -1 ))

  return result