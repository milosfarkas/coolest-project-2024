extends Node

var mob_speed_multiplier: float = 4.0/3.0
var current_level: int = 0
var size_of_levels: int = 1
var show_control: bool = true


func mob_speed() -> float:
	var game_round: int = current_level / size_of_levels
	var s = mob_speed_multiplier ** game_round
	print("mob_speed: " + str(s))
	return s
