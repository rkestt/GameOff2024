extends CharacterBody2D

#region Variables
# * Character proprieters
	# Animated Sprite
@onready var animatedSprite = $AnimatedSprite2D
# * Movement
@export var maxMoveSpeed : int = 300
@export var jumpVelocity = -300.0
@export var acceleration : int = 50
@export var stoppingSpeed : float = 0.2
	# gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	# movement check
var isFalling
var isJumping
var isJumpCanc
var isIdling
var isRunning
@export var gravityMultiplayer : float = 1.5;

#endregion

func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta) -> void:
	#* Manage gravity
	if not is_on_floor():
		velocity.y += (gravity*gravityMultiplayer) * delta

	#* Handle jump.
	isJumping = Input.is_action_just_pressed("jump") and is_on_floor()
	if isJumping:
		velocity.y = jumpVelocity

	#* Get Horizontal Movement
	var direction := Input.get_axis("move_left", "move_right")
	
	#* Rotate sprite
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
	
	#* Apply animation
	if velocity.x == 0:
		animatedSprite.play("idle")
	elif velocity.x != 0:
		animatedSprite.play("run")
	#* Apply movement
	if direction == 1 or direction == -1:
		velocity.x += direction * acceleration
	elif direction == 0:
		velocity.x = lerp(velocity.x,0.0,stoppingSpeed)

	#Dont let the speed go further
	if velocity.x > maxMoveSpeed:
		velocity.x = maxMoveSpeed
	elif velocity.x < -maxMoveSpeed:
		velocity.x = -maxMoveSpeed
	move_and_slide()
	
	
