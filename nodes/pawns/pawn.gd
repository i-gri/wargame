class_name Pawn extends Area2D

signal moved

@export var player:Player
@export var facing:int = 1

@onready var sprite:Sprite2D = $Sprite2D


var is_moving:bool = false

func _ready() -> void:
  if player:
    sprite.material = player.palette.duplicate()

  if facing == -1:
    sprite.flip_h = true



func move_to( new_position:Vector2 ) -> void:
  var tween = get_tree().create_tween()
  is_moving = true
  tween.tween_property( self, "position", new_position, .1 )
  tween.tween_callback( stopped_moving )


func stopped_moving() -> void:
  moved.emit()
  is_moving = false

func show_outline() -> void:
  sprite.material.set("shader_parameter/show_outline", false)

func hide_outline() -> void:
  sprite.material.set("shader_parameter/show_outline", true)

