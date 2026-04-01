class_name DeployZoneFilter extends Filter

@export var min_recon:int = 2

func execute( cell:Cell ) -> bool:
  return cell.core.recon_level >= min_recon

