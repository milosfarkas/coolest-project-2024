extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -320.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var weapon = $WeaponContainer
var facing_left: bool = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Attack.
	if Input.is_action_pressed("attack"):
		weapon.scale.x = 1 if facing_left else -1
		velocity.x = 100
		animation_player.play("attack")

	# Handle Jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
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
			
		
	move_and_slide()

