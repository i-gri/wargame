class_name BoardController extends Node

func make_pawn_draggable( pawn:Pawn ) -> void:
  var drag_component := Draggable.new()
  
  drag_component.drag_input_name = "select"

  pawn.add_child( drag_component )
  pawn.drag_component = drag_component


func undo_pawn_draggable( pawn:Pawn ) -> void:
  if pawn.drag_component == null: return

  pawn.drag_component.queue_free()
  pawn.drag_component = null


func add_pawn_dropzone( quadrant:Quadrant ) -> void:
  var dropzone := DropZone.new()

  dropzone.attach_spot = quadrant
  dropzone.drop_behavior = DropBehaviorReject.new()
  dropzone.snap_style = dropzone.SNAP_STYLE.SNAP_MARKERS

  # Logic for determining the eligible cells for movement

  quadrant.add_snap_dropzone( dropzone, quadrant.get_free_cells() )


func remove_pawn_dropzone( quadrant:Quadrant ) -> void:
  if quadrant.drop_zone == null: return

  quadrant.drop_zone.queue_free()
  quadrant.drop_zone = null