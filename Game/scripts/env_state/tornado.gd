extends EnvState

class_name Tornado

var original_scale: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	var timer = Timer.new()
	timer.timeout.connect(stop)
	add_child(timer)
	DURATION = 7
	timer.start(DURATION)

	original_scale = $Area2D/Maelstrom.scale
	$Area2D/Maelstrom.scale = Vector2(0.1, 0.1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	if disappearing:
		Util.shrink(delta, $Area2D/Maelstrom, original_scale, FADE_SECONDS)
	else:
		Util.grow(delta, $Area2D/Maelstrom, original_scale, FADE_SECONDS)

func restore_effects():
	$Area2D.gravity_space_override = 0
