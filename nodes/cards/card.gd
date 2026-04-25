class_name Card extends Area2D

@onready var draggable:Draggable = $Draggable
@onready var title:Label = $Title
@onready var text:Label = $Text

@export var core:CardCore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func filter() -> Callable:
	return core.get_filter()


func _on_drag_started( _area:Area2D ) -> void:
	scale = Vector2(.3,.3)

func _on_drag_ended( _area: Area2D, _drop_spot: SnappingSpot) -> void:
	scale = Vector2(1,1)
