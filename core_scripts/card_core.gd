class_name CardCore extends Resource

@export var title:String
@export var text:String

@export var recon_level:int = 2
@export var units:Array[UnitCore]

@export var filter:Filter

@export var bus:CardEventsBus

func play_on( cell:Cell, services:ServiceLocator ) -> void:
  if cell.core.recon_level < recon_level: return

  services.units_manager.deploy( cell, units )


func get_filter() -> Callable:
  return filter.execute
