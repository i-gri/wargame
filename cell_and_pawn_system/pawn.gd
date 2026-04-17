class_name Pawn extends Area2D

signal moved

func move_to( new_position:Vector2 ) -> void:
  var tween = get_tree().create_tween()
  tween.tween_property( self, "position", new_position, .1 )
  tween.tween_callback( moved.emit )