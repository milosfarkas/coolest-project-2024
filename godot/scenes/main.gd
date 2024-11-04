extends Node2D

@export var world_scene: PackedScene
var world: Node2D


func _ready() -> void:
	world = world_scene.instantiate()
	world.connect("mobs", refresh_ui)
	add_child(world)
	
func refresh_ui(mob_count, all):
	$UI.set_label("Remaining: " + str(mob_count) + "/" + str(all))
