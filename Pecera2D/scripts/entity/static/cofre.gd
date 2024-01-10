extends Static

const ModifierDir = "res://escenas/entity/modifier/"
const Burbuja = preload(ModifierDir + "/player_modifier/burbuja.tscn")
const OPEN_SECONDS = 4

var interactable = false
var spawns = []
var timer
var close_timer

signal cofre

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	# Start with the closed chest
	set_inside_spawn_pos([screen.x / 10, 9 * screen.x / 10], [7 * screen.y / 10, 9 * screen.y / 10])
	if global_position.x < screen.x/2:
		scale.x = -1

	$Sprite2D.frame = 0 
	spawns = [$Sprite2D/BubbleSpawn1.global_position,
				$Sprite2D/BubbleSpawn2.global_position]
				
	timer = Spawner.SpawnTimer.new(Burbuja, 999, 0.4, 0, 1, 0)
	add_child(timer)
	
	close_timer = Timer.new()
	close_timer.one_shot = true
	close_timer.timeout.connect(chest_close)
	add_child(close_timer)

func _on_interact_area_body_entered(body):
	if body is Player and timer.is_stopped():
		$Sprite2D.material.set_shader_parameter("line_thickness", 16)
		interactable = true

func _on_interact_area_body_exited(body):
	if body is Player:
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)
		interactable = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	
	if interactable and $Sprite2D.frame == 0 and Input.is_action_just_pressed("interact"):
		chest_open()


func chest_open():
	timer.start_timer()
	close_timer.start(OPEN_SECONDS)
	interactable = false

	PlayerVariables.xp_up.emit(20)
	$Sprite2D/AnimationPlayer.play("chest_open")
	$Sprite2D.material.set_shader_parameter("line_thickness", 0)
	
	# Dar XP al player
	emit_signal("cofre")


func chest_close():
	timer.stop()
	$Sprite2D/AnimationPlayer.play("chest_close")


