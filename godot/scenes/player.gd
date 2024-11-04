extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -300.0
@export var ATTACK_VELOCITY = 300
@onready var laser_sound = $LaserSound

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var weapon = $WeaponContainer
var facing_left: bool = true
var weapon_charged = true

func _ready():
	$WeaponContainer/weapon.visible = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += 0.7 * gravity * delta

	if is_on_floor():
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			
		var direction = Input.get_axis("ui_left", "ui_right")

		if direction == -1:
			animation.flip_h = false
			facing_left = true
		if direction == 1:
			animation.flip_h = true
			facing_left = false
		
		if direction:
			velocity.x = direction * SPEED
			animation.play("run")
		else:
			velocity.x = 0
			animation.play("idle")
	
	if Input.is_action_pressed("attack") and weapon_charged:
		weapon_charged = false
		weapon.scale.x = 1 if facing_left else -1
		velocity.x = -ATTACK_VELOCITY if facing_left else ATTACK_VELOCITY
		$WeaponChargerTimer.start()
		animation.play("attack")
		animation_player.play("attack")
		laser_sound.play()
	move_and_slide()



func _on_timer_timeout() -> void:
	weapon_charged = true
