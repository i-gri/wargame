class_name Cell extends Area2D

@export var debug:bool = false

var tile:Vector2i

func _ready() -> void:
	$DebugLabels.visible = debug

