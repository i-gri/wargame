class_name Pawn extends Area2D

signal moved

@onready var sprite:Sprite2D = $Sprite2D


func move_to( new_position:Vector2 ) -> void:
  var tween = get_tree().create_tween()
  tween.tween_property( self, "position", new_position, .1 )
  tween.tween_callback( moved.emit )


func _on_mouse_exited() -> void:
  sprite.material.set("shader_parameter/show_outline", false)

func _on_mouse_entered() -> void:
  sprite.material.set("shader_parameter/show_outline", true)

