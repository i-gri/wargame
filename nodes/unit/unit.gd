class_name Unit extends Area2D

@export var core:UnitCore
@export var player:Player

@onready var sprite:Sprite2D = $Sprite2D


func _ready() -> void:
  if core:
    sprite.texture = core.texture
    sprite.material = player.palette.duplicate()

