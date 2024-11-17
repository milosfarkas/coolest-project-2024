extends CharacterBody2D
class_name Mob

@export var SPEED = 50 
@export var animation_sprite: AnimatedSprite2D
@export var death_sound: AudioStreamPlayer2D
@export var detect_player_area: Area2D
@export var hurt_area: Area2D
@export var damage_points: int = 1
@export var collision: CollisionShape2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var player: Urhajos_Mr_Kicsi


func initialize():
	SPEED *= Backpack.mob_speed()
	animation_sprite.play("idle")
	detect_player_area.connect("body_entered", _on_detect_player_body_entered)
	detect_player_area.connect("body_exited", _on_detect_player_body_exited)
	hurt_area.connect("area_entered", _on_can_hurt_area_entered)
	hurt_area.connect("body_entered", _on_can_hurt_body_entered)


func _physics_process(delta):
	velocity.y += gravity * delta
	
	if player:
		var direction = (player.global_position - self.global_position).normalized()
		animation_sprite.play("run")
		animation_sprite.flip_h = direction.x > 0
		velocity.x = direction.x * SPEED
	else:
		animation_sprite.play("idle")
		velocity.x = 0
	move_and_slide()


func teleport_to_jail():
	if is_instance_valid(collision):
		collision.queue_free()
	death_sound.play()
	visible = false
	await death_sound.finished
	queue_free()


func _on_can_hurt_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurt"):
		teleport_to_jail()


func _on_detect_player_body_entered(body: Node2D) -> void:
	if body is Urhajos_Mr_Kicsi:
		player = body


func _on_detect_player_body_exited(body: Node2D) -> void:
	if body is Urhajos_Mr_Kicsi:
		player = null


func _on_can_hurt_body_entered(body: Node2D) -> void:
	if body is Urhajos_Mr_Kicsi:
		var kicsi: Urhajos_Mr_Kicsi = body
		kicsi.damage(damage_points)
