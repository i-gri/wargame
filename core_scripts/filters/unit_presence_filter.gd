class_name UnitPresenceFilter extends Filter

@export var number_of_units:int = 1


func execute( cell:Cell ) -> bool:
  return cell.occupied_sections.values().size() >= number_of_units