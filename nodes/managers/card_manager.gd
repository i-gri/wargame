class_name CardManager extends Node

@export var grid:GridManager
@export var hand:Hand
@export var service_locator:ServiceLocator

@export var cell_events_bus:CellEventsBus

func _ready() -> void:
  assert(hand, "Must have a hand attached")

  cell_events_bus.card_played.connect( _on_card_played )


func _on_card_played( cell:Cell, card:Card ) -> void:
  await card.play_on( cell, service_locator )
  hand.card_played( card )
