extends Area2D
class_name ExitArea


func _ready() -> void:
	visible = false


func _on_body_entered(body: Node2D) -> void:
	if body is Urhajos_Mr_Kicsi and visible:
		var kicsi: Urhajos_Mr_Kicsi = body
		kicsi.next_level()
