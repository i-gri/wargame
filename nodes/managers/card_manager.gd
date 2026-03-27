class_name CardManager extends Node

@export var hand:Hand

func _ready() -> void:
  assert(hand, "Must have a hand attached")

  hand.card_selected.connect( _on_card_selected )


func _on_card_selected( card:Card ) -> void:
  pass