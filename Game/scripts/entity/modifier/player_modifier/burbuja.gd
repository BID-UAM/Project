extends PlayerModifier

class_name Burbuja

func _ready():
	super()
	var spawns = get_parent().get_parent().spawns
	global_position = spawns[randi() % spawns.size()]
	FADE_SECONDS = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func _on_body_entered(body):
	if body is Pez or body is Player:
		disappear()
