class_name Unit extends Area2D

@export var core:UnitCore
@export var player:Player

const SCENE_ID:String = 'uid://ba5a321eieypp'

@onready var sprite:Sprite2D = $Sprite2D

static func construct( core_:UnitCore, player_:Player ) -> Unit:
  var node:Unit = load(SCENE_ID).instantiate()
  node.core = core_
  node.player = player_
  
  return node


func _ready() -> void:
  if core:
    sprite.texture = core.texture
    sprite.material = player.palette.duplicate()

