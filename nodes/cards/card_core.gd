class_name CardCore extends Resource


@export var title:String
@export var text:String
@export var filter:CellFilter

func get_filter() -> Callable:
	return filter.filter
