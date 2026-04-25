class_name CardController extends Node

signal card_played( core:CardCore, cell:Cell )

@export var eligible_cell_color:Color = Color(0.627, 1.0, 0.467, 0.553)

@export var hand:Hand
@export var grid:Grid
@export var card_events_bus:CardEventsBus

@export var player:Player

var eligible_cells:Array[Cell]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_events_bus.card_selected.connect( _on_card_selected )


func _on_card_selected( card:Card ) -> void:
	eligible_cells.assign( grid.get_all_cells().filter( card.filter().bind(player) ))

	for cell:Cell in eligible_cells:
		set_dropzone( cell )


func set_dropzone( cell ) -> void:
	var dropzone:DropZone = DropZone.new()
	dropzone.attach_spot = cell
	dropzone.drop_behavior = DropBehaviorReject.new()
	dropzone.snap_style = dropzone.SNAP_STYLE.NO_SNAP

	cell.add_child( dropzone )
	cell.dropzone = dropzone
	cell.overlay.visible = true
	cell.overlay.modulate = eligible_cell_color


	dropzone.drop_accepted.connect( _on_card_play )


func unset_dropzone( cell:Cell ) -> void:
	cell.dropzone.drop_accepted.disconnect( _on_card_play )
	cell.dropzone.queue_free()
	cell.dropzone = null
	cell.outline.visible = false
	cell.overlay.visible = false


func _on_card_play( target_dropzone: DropZone, card: Card, _plan: DropPlan ) -> void:
	for cell:Cell in eligible_cells:
		unset_dropzone( cell )

	card_played.emit( card.core, target_dropzone.get_parent() )
	hand.card_played( card )
