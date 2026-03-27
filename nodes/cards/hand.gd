class_name Hand extends Node2D

@export var card_events_bus:CardEventsBus

@export var card_width:int = 80
@export var card_padding:int = 10

var cards:Array[Card] = []


func _ready() -> void:
  for card:Node in get_children():
    if card is not Card: continue

    connect_card( card )
    cards.append( card )

  if cards.is_empty(): return

  update_card_positions()


func connect_card( card:Card ) -> void:
  card.draggable.drag_started.connect( _on_card_dragged )

func update_card_positions() -> void:
  for i in range( cards.size()):
    var new_position := Vector2( calculate_new_card_position(i), 0)

    animate_card_to_position( new_position, cards[i] )


func calculate_new_card_position( index:int ) -> float:
  var total_width:float = ( cards.size() - 1 ) * card_width

  return ( index * card_width + card_padding ) - total_width/2


func animate_card_to_position( new_position:Vector2, card:Card ) -> void:
  var tween = get_tree().create_tween()
  tween.tween_property( card, "position", new_position, .1 )


func _on_card_dragged( card:Card ) -> void:
  card_events_bus.card_selected.emit( card )


func card_played( card ) -> void:
  cards.erase( card )
  card.queue_free()
  update_card_positions()