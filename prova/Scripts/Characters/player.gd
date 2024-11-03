extends CharacterBody2D

#region Variables
# * Character proprieters
# * Movement
@export var moveSpeed : int = 300
@export var jumpVelocity = -300.0
	#gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var gravityMultiplayer : float = 1.5;

#endregion

func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta) -> void:
	# * Manage gravity
	if not is_on_floor():
		velocity.y += (gravity*gravityMultiplayer) * delta

	# * Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity

	# * Output Horizontal Movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * moveSpeed
	else:
		velocity.x = 0
	
	move_and_slide()
	# * Rotate sprite
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
	