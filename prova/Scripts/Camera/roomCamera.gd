extends Camera2D

class_name RoomTransisionCamera
#region Variables
	#* Position
var currentRoomPosition : Vector2 = Vector2.ZERO #Inizialize the start room
@onready var cameraHorizontalMovement : int = get_viewport_rect().size.x - horizontalOffset
@onready var cameraVerticalMovement : int = get_viewport_rect().size.y - verticalOffset
	#Target
@export var targetNode : Node2D = null
	#! transition number
@export var horizontalOffset : int = 10
@export var verticalOffset : int = 10
	#Offset of the world
var originOffset : Vector2 = Vector2.ZERO
#endregion
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originOffset = targetNode.get_position()
	set_position(originOffset)


#region Update 
func updateCameraPosition(direction: Vector2) -> void:
	print("Posizione della camera " + str(global_position))
	currentRoomPosition += direction
	set_position(originOffset + currentRoomPosition * Vector2(cameraHorizontalMovement, cameraVerticalMovement))
#endregion
#region Signal for transition

func _OnBodyEnteredTop(body:Node2D) -> void:
	pass # Replace with function body.
	updateCameraPosition(Vector2.UP)

func _OnBodyEnteredRight(body:Node2D) -> void:
	updateCameraPosition(Vector2.RIGHT)

func _OnBodyEnteredLeft(body:Node2D) -> void:
	updateCameraPosition(Vector2.LEFT)

func _OnBodyEnteredBottom(body:Node2D) -> void:
	updateCameraPosition(Vector2.DOWN)
#endregion
