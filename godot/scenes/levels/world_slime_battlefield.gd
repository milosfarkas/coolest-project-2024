extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
