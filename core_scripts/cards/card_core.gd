class_name CardCore extends Resource

@export var title:String
@export var text:String


@export var filter:Filter

@export var bus:CardEventsBus

func play_on( cell:Cell, services:ServiceLocator ) -> void:
  pass


func get_filter() -> Callable:
  return filter.execute
