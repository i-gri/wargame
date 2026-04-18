class_name Grid extends TileMapLayer

signal cell_selected(cell: Cell)

const CELL_SCENE_ID: String = "uid://btsk60egvukhj"

var cells: Dictionary[Vector2i, Cell] = {}


func _ready() -> void:
	var scene: PackedScene = load(CELL_SCENE_ID)

	for tile: Vector2i in get_used_cells():
		var node: Cell = scene.instantiate()

		node.position = map_to_local(tile)
		node.tile = tile
		node.input_event.connect(_on_cell_click.bind(node))
		

		cells[tile] = node
		add_child(node)


func get_cell_in_position(cell_position: Vector2) -> Cell:
	var tile: Vector2i = local_to_map(cell_position)

	return cells.get(tile)


func _on_cell_click(_viewport: Node, event: InputEvent, _shape_ids: int, cell: Cell) -> void:
	if event is not InputEventMouseButton: return

	if event.is_action_released("select"):
		cell_selected.emit(cell)
