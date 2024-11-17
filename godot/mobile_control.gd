extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = Backpack.show_control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_buttons"):
		visible = not visible
		Backpack.show_control = visible
