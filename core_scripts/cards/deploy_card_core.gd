class_name DeployCardCore extends CardCore

@export var recon_level:int = 2
@export var units:Array[UnitCore]

func play_on( cell:Cell, services:ServiceLocator ) -> void:
  if cell.core.recon_level < recon_level: return

  services.units_manager.deploy( cell, units )