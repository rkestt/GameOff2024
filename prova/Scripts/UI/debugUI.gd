extends PanelContainer

@export var isVisible = true
#* Container
@onready var propertyContainer = $MarginContainer/VBoxContainer
var property
#* General

#* Things to add
@export var fpsCounter : String

#Ready 
func _ready() -> void:
	#Set global reference
	Global.debug = self;

#Update it
func _process(delta: float) -> void:
	fpsCounter = "%.2f" % (1.0/delta)
	addProperty("FPS", fpsCounter,0)

func _input(event) -> void:
	if Input.is_action_pressed("debugPanel"):
		isVisible = !isVisible

func addProperty(title: String,value,order):
	var target
	target = propertyContainer.find_child(title,true,false) #Find specific label
	if !target:
		target = Label.new()
		propertyContainer.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		propertyContainer.move_child(target,order)
