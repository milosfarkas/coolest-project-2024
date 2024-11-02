extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var SPEED = 50 


func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_slide()

func teleport_to_jail():
	$DeathSound.play()
	self.visible = false
	await $DeathSound.finished
	self.queue_free()

func _on_can_hurt_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurt"):
		teleport_to_jail()
