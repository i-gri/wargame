class_name Token extends Sprite2D

@export var spawn_move:Vector2 = Vector2(0, -50)

var dice:DiceFace

func _ready() -> void:
  if dice == null: return

  texture = dice.face

  var tween = get_tree().create_tween()
  tween.tween_property( self, "position", position + spawn_move, 1 )
  tween.tween_callback( queue_free )