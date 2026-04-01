class_name UnitsManager extends Node

@export var current_player:Player
@export var grid:GridManager 

func _ready() -> void:
  await get_parent().ready

  scan_units()

  
func scan_units() -> void:
  for unit:Node in get_children():
    if unit is not Unit: continue

    var cell:Cell = grid.get_cell_in_position( unit.position )

    var segment:Vector2i = cell.calculate_position_to_tile( unit.position )

    cell.add_unit( unit, segment )



func deploy_in_cell( cell:Cell, units:Array[UnitCore], player:Player ) -> void:
  var segments:Array[Vector2i] = cell.get_all_segments()
  segments.shuffle()

  for core:UnitCore in units:
    var unit:Unit = Unit.construct( core, player )
    var segment:Vector2i = segments.pop_back()
    unit.position = cell.calculate_section_to_position( segment ) + cell.global_position
    cell.add_unit( unit, segment)

    add_child( unit )


func deploy( cell:Cell, units:Array[UnitCore] ) -> void:
  deploy_in_cell( cell, units, current_player )



