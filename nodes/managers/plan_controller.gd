class_name PlanController extends Node


@export var card_events_bus:CardEventsBus

@export var grid:Grid
@export var pawns_manager:PanwManager
@export var pawn_controller:PawnController
@export var card_controller:CardController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  card_controller.card_played.connect( _on_card_played )


func _on_card_played( card:Card, cell:Cell ) -> void:
  card.queue_free()