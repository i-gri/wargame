class_name PanwManager extends Node

@export var initial_facings:Dictionary[Player, int]

const PAWN_BASIC_SCENE_ID:String = "uid://csakj4dhgi3xd"

func create_pawn( player:Player ) -> Pawn:
  var node:Pawn = load( PAWN_BASIC_SCENE_ID ).instantiate()

  node.player = player
  node.facing = initial_facings.get(player, -1)

  return node


func deploy_unit( position:Vector2, player:Player ) -> void:
  var unit:Pawn = create_pawn( player )

  unit.position = position

  add_child( unit )