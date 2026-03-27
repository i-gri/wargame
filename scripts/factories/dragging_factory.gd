class_name DraggingFactory

static func create_draggable() -> Draggable:
  var node:Draggable = Draggable.new()

  node.drag_input_name = "select"

  return node

static func create_snap_dropzone( attach_spot:Area2D ) -> DropZone:
  var dropzone:DropZone = DropZone.new()
  dropzone.attach_spot = attach_spot
  dropzone.drop_behavior = DropBehaviorReject.new()
  dropzone.snap_style = dropzone.SNAP_STYLE.SNAP_MARKERS

  return dropzone


static func create_simple_dropzone( attach_spot:Area2D ) -> DropZone:
  var dropzone:DropZone = DropZone.new()
  dropzone.attach_spot = attach_spot
  dropzone.drop_behavior = DropBehaviorReject.new()
  dropzone.snap_style = dropzone.SNAP_STYLE.NO_SNAP

  return dropzone