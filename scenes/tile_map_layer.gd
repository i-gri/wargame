extends TileMapLayer

func _ready() -> void:
  for tile:Node in get_children():
    print_debug( tile )
