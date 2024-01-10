extends Control

@export var fish: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_fish_pressed(fishName: String):
	PlayerVariables.fish_selected = fishName
	self.hide()
