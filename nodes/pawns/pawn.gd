class_name Pawn extends Area2D

signal moved

@export var player:Player
@export var facing:int = 1

@onready var sprite:Sprite2D = $Sprite2D


func _ready() -> void:
  if player:
    sprite.material = player.palette.duplicate()

  if facing == -1:
    sprite.flip_h = true



func move_to( new_position:Vector2 ) -> void:
  var tween = get_tree().create_tween()
  tween.tween_property( self, "position", new_position, .1 )
  tween.tween_callback( moved.emit )


func show_outline() -> void:
  sprite.material.set("shader_parameter/show_outline", false)

func hide_outline() -> void:
  sprite.material.set("shader_parameter/show_outline", true)

