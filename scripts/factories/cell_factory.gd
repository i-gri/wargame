class_name CellFactory

const SCENE_PATH:String = "uid://h5ua7mkblwyn"

var scene:PackedScene

func _init() -> void:
  scene = load( SCENE_PATH )

func create( tile:Vector2i, position:Vector2, core:CellCore = CellCore.new()) -> Cell:
  var node:Cell = scene.instantiate()

  if core == null:
    core = CellCore.new()
    
  node.tile = tile
  node.position = position
  node.core = core

  return node
