extends Node2D

signal mobs(remaining, all)
signal changed_player_health(health)

@onready var mobs_node = $Mobs
@onready var player = $Player

var all_mobs: int


func count_mobs():
	return mobs_node.get_child_count()


func _ready() -> void:
	all_mobs = count_mobs()
	$AudioStreamPlayer.play()
	player.connect("health_changed", player_health_changed)
	mobs.emit(count_mobs(), all_mobs)


func player_health_changed(health):
	changed_player_health.emit(health)


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()


func _on_mobs_child_order_changed() -> void:
	mobs.emit(count_mobs(), all_mobs)
