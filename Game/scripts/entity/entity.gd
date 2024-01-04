extends RigidBody2D

class_name Entity

var rng = RandomNumberGenerator.new()
var screen = DisplayServer.window_get_size()

var FADE_SECONDS = 1.5
var disappearing = false
var parent = null

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()

	# randomize initial position
	set_inside_spawn_pos()
	
	# modify modulation to start invisible
	modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disappearing:
		Util.fade(delta, self)
	else:
		Util.unfade(delta, self)


func set_inside_spawn_pos(x_limits=[0, screen.x], y_limits=[0, screen.y]):
	global_position.x = rng.randf_range(x_limits[0], x_limits[1])
	global_position.y = rng.randf_range(y_limits[0], y_limits[1])

func set_outside_spawn_pos(left=true, right=true, top=true, bottom=true):
	var dims = screen / 6
	var horizontal = true in [left, right]
	var vertical = true in [top, right]

	# Horizontal
	if horizontal and (not vertical or rng.randi_range(0, 1) == 0):
		# Left
		if left and (not right or rng.randi_range(0, 1) == 0):
			global_position.x = -dims.x
		# Right
		elif right:
			global_position.x = screen.x + dims.x
		global_position.y = rng.randf_range(0, screen.y)
	# Vertical
	elif vertical:
		# Top
		if top and (not bottom or rng.randi_range(0, 1) == 0):
			global_position.y = -dims.y
		# Bottom
		elif bottom:
			global_position.y = screen.y + dims.y
		global_position.x = rng.randf_range(0, screen.x)

func disappear():
	disappearing = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	if global_position.x < 0 or global_position.x > screen.x or global_position.y < 0 or global_position.y > screen.y:
		queue_free()
