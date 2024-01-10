extends PlayerModifier

class_name Mina

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	global_position.y = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)


func do_effect(player):
	if not PlayerVariables.invulnerable:
		PlayerVariables.damage.emit()
