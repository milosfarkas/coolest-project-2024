extends Area2D

@export var enable_collision: bool :
	get:
		return not $SwordCollision.disabled
	set(value):
		$SwordCollision.disabled = not value

func _ready():
	enable_collision = false
	
