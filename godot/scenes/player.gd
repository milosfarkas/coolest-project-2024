extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -320.0
@export var ATTACK_VELOCITY = 800
@onready var laser_sound = $LaserSound

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var weapon = $WeaponContainer
var facing_left: bool = true


func _ready():
	$WeaponContainer/weapon.visible = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("attack"):
		weapon.scale.x = 1 if facing_left else -1
		velocity.x = -ATTACK_VELOCITY if facing_left else ATTACK_VELOCITY
		animation_player.play("attack")
	
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
	
	if Input.is_action_pressed("attack"):
		animation.play("attack")
		laser_sound.play()
	move_and_slide()

