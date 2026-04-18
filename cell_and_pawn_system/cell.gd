class_name Cell extends Area2D

@export var debug:bool = false

var pawns:Array[Pawn] = []
var tile:Vector2i

func _ready() -> void:
	$DebugLabels.visible = debug


func _on_pawn_entered( pawn: Pawn ) -> void:
	pawns.append( pawn )

func _on_pawn_exited( pawn: Pawn ) -> void:
	pawns.erase( pawn )

