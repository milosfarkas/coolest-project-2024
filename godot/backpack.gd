extends Node

const mob_speed_multiplier: float = 4.0/3.0

var current_level: int = 0
var size_of_levels: int = 1
var show_control: bool = true


func mob_speed() -> float:
	var game_round: int = floor(current_level / size_of_levels)
	return mob_speed_multiplier ** game_round
