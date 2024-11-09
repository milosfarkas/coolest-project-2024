extends Area2D

var coll_enabled

@export var enable_collision: bool :
	get:
		return coll_enabled
	set(value):
		coll_enabled = value
		$SwordCollision.disabled = not coll_enabled

func _ready():
	enable_collision = false
	
