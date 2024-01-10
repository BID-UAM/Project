extends VBoxContainer

@onready var xp=get_node("TextureProgressBar")
@onready var level=get_node("Number")
var xp_level = 1
var xp_value = 0
func _ready():
	xp.min_value=0

func setMaxValue(value):
	xp.max_value=value
func setValue(value):
	xp.value=value
func setLevel(value):
	xp_level=value
	level.text="Nivel: " + str(xp_level)

