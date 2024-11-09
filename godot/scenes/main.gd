extends Node2D

@export var world_scene: PackedScene
var world: Node2D


func _ready() -> void:
	world = world_scene.instantiate()
	world.connect("mobs", refresh_ui)
	world.connect("changed_player_health", changed_player_health)
	add_child(world)
	
func refresh_ui(mob_count, _all):
	$UI.remaining_enemies(mob_count)
	
func changed_player_health(h):
	$UI.player_health(h)
