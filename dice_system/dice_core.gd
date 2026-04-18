class_name DiceCore extends Resource

@export var sides:Array[DiceFace]

func roll() -> DiceFace:
  return sides.pick_random()