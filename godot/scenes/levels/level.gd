extends Node2D
class_name Level


signal mobs(remaining, all)
signal changed_player_health(health)

@export var mobs_node: Node2D
@export var player: Urhajos_Mr_Kicsi
@export var exit: ExitArea
@export var music: AudioStreamPlayer

var all_mobs: int


func count_mobs():
	return mobs_node.get_child_count()
	
	
func open_exit():
	if is_instance_valid(exit):
		exit.visible = true
	

func initialize() -> void:
	all_mobs = count_mobs()
	mobs.emit(count_mobs(), all_mobs)
	music.play()
	
	mobs_node.connect("child_order_changed", _on_mobs_child_order_changed)
	music.connect("finished", _on_audio_stream_player_finished)
	player.connect("health_changed", player_health_changed)
	


func player_health_changed(health):
	changed_player_health.emit(health)


func _on_audio_stream_player_finished() -> void:
	music.play()


func _on_mobs_child_order_changed() -> void:
	mobs.emit(count_mobs(), all_mobs)
