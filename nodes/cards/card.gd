class_name Card extends Area2D

@onready var draggable:Draggable = $Draggable
@onready var title:Label = $Title
@onready var text:Label = $Text

@export var core:CardCore

func _ready() -> void:
  if core == null: return

  title.text = core.title
  text.text = core.text


func play_on( cell:Cell, service_locator:ServiceLocator ) -> void:
  await core.play_on( cell, service_locator )
