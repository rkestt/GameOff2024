extends Camera2D

class_name RoomTransisionCamera
#region Variables
	#* Position
var currentRoomPosition : Vector2 = Vector2.ZERO #Inizialize the start room
@onready var cameraHorizontalMovement : int = get_viewport_rect().size.x - horizontalOffset
@onready var cameraVerticalMovement : int = get_viewport_rect().size.y - verticalOffset
	#! transition number
@export var horizontalOffset : int = 10
@export var verticalOffset : int = 10

#endregion
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


#region Update 
func updateCameraPosition(direction: Vector2) -> void:
	currentRoomPosition += direction
	set_position(currentRoomPosition * Vector2(cameraHorizontalMovement, cameraVerticalMovement))
#endregion
#region Signal for transition
func _OnBodyEnteredBottom(body:Node2D) -> void:
	pass # Replace with function body.


func _OnBodyEnteredLeft(body:Node2D) -> void:
	pass # Replace with function body.


func _OnBodyEnteredRight(body:Node2D) -> void:
	pass # Replace with function body.


func _OnBodyEnteredTop(body:Node2D) -> void:
	pass # Replace with function body.

#endregion