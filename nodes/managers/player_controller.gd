class_name PlayerController extends Node

@export var grid:GridManager
@export var units_manager:UnitsManager

@export var player:Player


func wrap_cell( cell:Cell, card:CardCore ) -> void:
  for unit:Unit in cell.get_units_for( player ):
    unit.add_draggable( Draggable.new() )
