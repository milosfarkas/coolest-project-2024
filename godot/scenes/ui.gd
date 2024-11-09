extends CanvasLayer

@onready var enemies: Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/PanelContainer/HBoxContainer/EnemiesLeft
@onready var player: Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/PanelContainer/HBoxContainer/PlayerHealth


func remaining_enemies(num: int):
	enemies.text = str(num)

func player_health(health: int):
	player.text = str(health)
		
