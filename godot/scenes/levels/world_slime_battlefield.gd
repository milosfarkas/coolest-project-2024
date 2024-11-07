extends Node2D

signal mobs(remaining, all)

var all_mobs: int

func count_mobs():
	return %Mobs.get_child_count()

func _ready() -> void:
	all_mobs = count_mobs()
	$AudioStreamPlayer.play()
	mobs.emit(count_mobs(), all_mobs)


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()


func _on_mobs_child_order_changed() -> void:
	mobs.emit(count_mobs(), all_mobs)
