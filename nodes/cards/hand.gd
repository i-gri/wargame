class_name Hand extends Node2D

signal card_selected( card:Card )

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
  card.input_event.connect( _on_card_selected.bind( card ) )
  card.draggable.drag_started.connect( _on_card_dragged )
  card.played.connect( _on_card_played )

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


func _on_card_selected( _viewport:Viewport, event:InputEvent, _shape_idx: int, card:Card ) -> void:
  if not event.is_action_released("select"): return 

  card_selected.emit( card )


func _on_card_dragged( card:Card ) -> void:
  card_selected.emit( card )


func _on_card_played( card:Card ) -> void:
  pass