extends HBoxContainer

@onready var ep=get_node("TextureProgressBar")
@onready var level=get_node("Bar/Count/Number")
var ep_level=1
var ep_value=0
func _ready():
	ep.min_value=0

func setMaxValue(value):
	ep.max_value=value
func setValue(value):
	ep.value=value
func setLevel(value):
	ep_level=value
	level.text="Level:"+str(ep_level)

