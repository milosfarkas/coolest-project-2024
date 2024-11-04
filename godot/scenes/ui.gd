extends CanvasLayer

@onready var label: Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/PanelContainer/Label


func set_label(text: String):
	label.text = text
		
