extends Node2D

var world: Node2D
@export var level_scenes: Array[PackedScene]
@export var win_sound: AudioStreamPlayer


func _ready() -> void:
	var scene_num = Backpack.current_level % level_scenes.size()	
	Backpack.size_of_levels = level_scenes.size()
	print("level: ", scene_num)
	print("mob speed: ", Backpack.mob_speed())
	
	world = level_scenes[scene_num].instantiate()
	world.connect("mobs", refresh_ui)
	world.connect("changed_player_health", changed_player_health)
	add_child(world)

	
func refresh_ui(mob_count, _all):
	$UI.remaining_enemies(mob_count)
	if mob_count == 0:
		world.open_exit()
		win_sound.play()
	
	
func changed_player_health(h):
	$UI.player_health(h)
