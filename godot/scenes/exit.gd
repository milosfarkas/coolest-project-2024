extends Area2D
class_name ExitArea

var open = false
	
func _on_body_entered(body: Node2D) -> void:
	if body is Urhajos_Mr_Kicsi and open:
		var kicsi: Urhajos_Mr_Kicsi = body
		kicsi.next_level()
