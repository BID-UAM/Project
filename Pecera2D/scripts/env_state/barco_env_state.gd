extends EnvState

var speed = 2
var direction = Vector2(1,0)

const ModifierDir = "res://escenas/entity/modifier/"
const BasuraClass = preload(ModifierDir + "/player_modifier/basura.tscn")

var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	timer = Spawner.SpawnTimer.new(BasuraClass, 999, 0.5, 0, 1, 0)
	get_parent().add_child(timer)
	timer.start_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	$Barco.position = $Barco.position + speed * direction

func exit():
	timer.stop()
	disappear()

