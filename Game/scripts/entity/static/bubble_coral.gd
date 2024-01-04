extends Static

class_name Bubble_Coral

var bodies_inside_count = 0

const ModifierDir = "res://escenas/entity/modifier/"
const BurbujaCoralClass = preload(ModifierDir + "/player_modifier/burbuja.tscn")

var slowTimer
var fastTimer

# global var with spawner positions
var spawns = []

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	global_position.y = screen.y
	
	spawns = [
	 $BubbleSpawn1.global_position,
	 $BubbleSpawn2.global_position,
	 $BubbleSpawn3.global_position
	]
	# 	func _init(item_class, max, wait, dev=0, spawn_num=1, spawn_dev=0):
	slowTimer = Spawner.SpawnTimer.new(BurbujaCoralClass, 999, 2, 0, 1, 0)
	fastTimer = Spawner.SpawnTimer.new(BurbujaCoralClass, 999, 0.5, 0, 1, 0)
	add_child(slowTimer)
	add_child(fastTimer)
	slowTimer.start_timer()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func _on_observer_entered():
	bodies_inside_count += 1
	if bodies_inside_count == 1:
		slowTimer.stop()
		fastTimer.start_timer()
		# countdown = countdown_fast

func _on_observer_exited():
	bodies_inside_count -= 1
	if bodies_inside_count == 0:
		slowTimer.start_timer()
		fastTimer.stop()
		# countdown = countdown_slow

func _on_observer_body_entered(body):
	if body.is_in_group("player"):
		_on_observer_entered()

func _on_observer_body_exited(body):
	if body.is_in_group("player"):
		_on_observer_exited()
