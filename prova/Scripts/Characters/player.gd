extends CharacterBody2D

class_name Player
#region Variables
# * Character proprieters
	#Objects
@onready var playerCamera
	# Animated Sprite
@onready var animatedSprite = $AnimatedSprite2D
#* Movement
	# Horizontal
@export_group("Horizontal Movement")
@export var maxMoveSpeed : int = 300
@export var acceleration : int = 50
@export var stoppingSpeed : float = 0.3
	#Vertical
@export_group("Vertical Movement")
@export var jumpHeight : float = 90.0
@export var jumpTimePeak : float = 0.5
@export var jumpTimeDescent : float = 0.4

@onready var jumpVelocity : float = ((2.0 * jumpHeight) / jumpTimePeak) * -1.0
@onready var jumpGravity : float = ((-2.0 * jumpHeight) / (jumpTimePeak * jumpTimePeak)) * -1.0
@onready var fallGravity : float = ((-2.0 * jumpHeight) / (jumpTimeDescent * jumpTimeDescent)) * -1.0
	# movement check
var isFalling
var isJumping
var isJumpCanc
var isIdling
var isRunning
#endregion

#region Ready Functions

#endregion
#region Update Functions
func _process(delta: float) -> void:
	#Add parameters to debug
	Global.debug.addProperty("Speed",velocity.x,1)

func _physics_process(delta: float) -> void:
	movement(delta)

	#* Manage gravity
	velocity.y += getGravity() * delta
	#* Handle jump.
	isJumping = Input.is_action_pressed("jump") and is_on_floor()
	if isJumping:
		jump(delta)

#endregion

#region Movement
func movement(delta) -> void:
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
	
func jump(delta) -> void:
	velocity.y = jumpVelocity
func getGravity() -> float:
	return jumpGravity if velocity.y < 0.0 else fallGravity
#endregion

#region General

#endregion
