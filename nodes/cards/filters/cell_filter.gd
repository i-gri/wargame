class_name CellFilter extends Resource


func filter( cell:Cell, player:Player ) -> bool:
  return pawn_filter( cell.get_player_pawns( player ) )

func pawn_filter( pawns:Array[Pawn] ) -> bool:
  return not pawns.is_empty()