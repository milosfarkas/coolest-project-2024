extends CharacterBody2D
class_name Urhajos_Mr_Kicsi

signal health_changed(health)

var current_health = 10
var damagable = true
var attacking = false
var dying = false
var already_going_to_next_level = false

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -320.0
@export var ATTACK_VELOCITY = 800
@onready var laser_sound = $LaserSound
@onready var damage_sound = $DamageSound
@onready var dying_sound = $DyingSound

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var weapon = $WeaponContainer
@onready var attack_timer = $WeaponChargerTimer
var facing_left: bool = true


func _ready():
	$WeaponContainer/weapon.visible = false
	health_changed.emit(current_health)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	# Handle Jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = false
		facing_left = true
	if direction == 1:
		get_node("AnimatedSprite2D").flip_h = true
		facing_left = false
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animation.play("idle")
	
	if Input.is_action_pressed("attack") and not attacking:
		attacking = true
		damagable = false

		# DASH
		weapon.scale.x = 1 if facing_left else -1
		velocity.x = -ATTACK_VELOCITY if facing_left else ATTACK_VELOCITY

		animation_player.play("the_attack_animation")
		animation.play("attack")
		laser_sound.play()
		attack_timer.start()
		
	move_and_slide()


func damage(hit: int):
	if damagable:
		damagable = false
		damage_sound.play()
		current_health = max(0, current_health - hit)
		health_changed.emit(current_health)
		await damage_sound.finished
		damagable = true
		if current_health == 0:
			die()

func reload():
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")	



func die():
	if not dying:
		dying = true
		print("haldoklik")
		visible = false
		dying_sound.play()
		await dying_sound.finished
		print("meghalt")
		reload()


func next_level():
	if not already_going_to_next_level:
		already_going_to_next_level = true
		var _current_level = Backpack.current_level
		var _next_level = _current_level + 1
		Backpack.current_level = _next_level
		print("Mr Kicsi megy a kovetkezo palyara: ", str(_current_level), "->", str(_next_level))
		reload()
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "the_attack_animation":
		damagable = true


func _on_weapon_charger_timer_timeout() -> void:
	attacking = false
