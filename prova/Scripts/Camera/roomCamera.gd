extends Camera2D

class_name RoomTransisionCamera
#region Variables
	#* Position
var currentRoomPosition : Vector2 = Vector2.ZERO #Inizialize the start room
@onready var cameraHorizontalMovement : int = get_viewport_rect().size.x - horizontalOffset
@onready var cameraVerticalMovement : int = get_viewport_rect().size.y - verticalOffset
	#Target
@export var targetNode : Node2D = null
@export var playerChangePositionForCamera : int =  10
	#! transition number
@export var horizontalOffset : int = 10
@export var verticalOffset : int = 10
@export var cameraTravelTime : float = 1
	#Offset of the world
var originOffset : Vector2 = Vector2.ZERO
#* Status of camera
var isCameraTransitioning : bool = false
#endregion
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originOffset = targetNode.get_position()
	set_position(originOffset)


#region Update 
func updateCameraPosition(direction: Vector2) -> void:
	if isCameraTransitioning:
		print("Posizione della camera " + str(global_position))
		#Freeze entities
		Global.freezeOnSpot()
		
		# Sposta leggermente il giocatore nella stessa direzione della telecamera
		if targetNode != null:
			targetNode.position += direction * playerChangePositionForCamera # Modifica 10 con la distanza desiderata per lo spostamento
		#Find final position
		var tween = create_tween()
		currentRoomPosition += direction
		var finalCameraPos = originOffset + currentRoomPosition * Vector2(cameraHorizontalMovement, cameraVerticalMovement)
		tween.tween_property(self, "position", finalCameraPos, cameraTravelTime)
		
		#Signal for unlock 
		tween.connect("finished", Callable(self, "on_transition_finished"))
#endregion

#region Signal for transition
func on_transition_finished():
	
	isCameraTransitioning = false
	
	Global.freezeOnSpot()  # Sblocca le entità

	# Aggiungi qui la tua condizione o logica aggiuntiva da avviare
	print("La camera ha completato il movimento!")
	# Puoi aggiungere qui un'altra funzione, stato o evento che vuoi avviare.
func _OnBodyEnteredTop(body:Node2D) -> void:
	isCameraTransitioning = !isCameraTransitioning
	updateCameraPosition(Vector2.UP)

func _OnBodyEnteredRight(body:Node2D) -> void:
	isCameraTransitioning = !isCameraTransitioning
	updateCameraPosition(Vector2.RIGHT)

func _OnBodyEnteredLeft(body:Node2D) -> void:
	isCameraTransitioning = !isCameraTransitioning
	updateCameraPosition(Vector2.LEFT)

func _OnBodyEnteredBottom(body:Node2D) -> void:
	isCameraTransitioning = !isCameraTransitioning
	updateCameraPosition(Vector2.DOWN)
#endregion
