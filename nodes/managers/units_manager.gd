class_name UnitsManager extends Node

func deploy_in_cell( cell:Cell, units:Array[UnitCore], player:Player ) -> void:
  var tiles:Array[Vector2i] = cell.get_all_segments()
  tiles.shuffle()

  for core:UnitCore in units:
    var unit:Unit = Unit.construct( core, player )
    var tile:Vector2i = tiles.pop_back()
    unit.position = cell.calculate_section_to_position( tile ) + cell.global_position
    cell.add_unit( unit, tile)

    add_child( unit )





