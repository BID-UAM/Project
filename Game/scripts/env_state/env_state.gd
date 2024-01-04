extends Node2D

class_name EnvState

const FADE_SECONDS = 1.5
var DURATION = 10
var disappearing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disappearing:
		Util.fade(delta, self)
	else:
		Util.unfade(delta, self)

func stop():
	disappear()
	restore_effects()

func disappear():
	disappearing = true

func restore_effects():
	pass
