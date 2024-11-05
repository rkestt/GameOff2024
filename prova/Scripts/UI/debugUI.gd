extends PanelContainer

@export var isVisible = true
#* Container
@onready var propertyContainer = $MarginContainer/VBoxContainer
var property
#* Things to add
@export var fpsCounter : String

#Ready 
func _ready() -> void:
	addDebugProp("FPS: ", fpsCounter)
#Update it
func _process(delta: float) -> void:
	fpsCounter = "%.2f" % (1.0/delta)
	property.text = property.name + ": " + fpsCounter
func _input(event) -> void:
	if Input.is_action_pressed("debugPanel"):
		isVisible = !isVisible

func addDebugProp(title: String.value):
	property = Label.new()
	propertyContainer.add_child(property)
	property.name = title
	property.text = property.name + value
