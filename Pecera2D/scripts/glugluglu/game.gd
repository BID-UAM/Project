extends Node2D

const ModifierDir = "res://escenas/entity/modifier/"

const MinaClass = preload(ModifierDir + "player_modifier/mina.tscn")
const BasuraClass = preload(ModifierDir + "player_modifier/basura.tscn")
const SeaweedClass = preload(ModifierDir + "player_modifier/seaweed.tscn")
const BarrilClass = preload(ModifierDir + "env_modifier/barril.tscn")

const PezClass = [
	preload(ModifierDir + "player_modifier/pez/nemo_npc.tscn"),
	preload(ModifierDir + "player_modifier/pez/blinky_npc.tscn"),
	preload(ModifierDir + "player_modifier/pez/tortuga_npc.tscn"),
	preload(ModifierDir + "player_modifier/pez/dory_npc.tscn"),
	preload(ModifierDir + "player_modifier/pez/tiburon_npc.tscn")
]

const TiburonAsesinoClass = preload(ModifierDir + "player_modifier/pez/tiburon_asesino.tscn")

const EnvModifierClass = [
	preload(ModifierDir + "env_modifier/tapón.tscn"),
	preload(ModifierDir + "env_modifier/cebo.tscn"),
	preload(ModifierDir + "env_modifier/magma.tscn")
]

const BubbleCoralClass = preload("res://escenas/entity/static/bubble_coral.tscn")
const CofreClass = preload("res://escenas/entity/static/cofre.tscn")

var pezTimer
var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVariables.game_over.connect(end_game)
	PlayerVariables.level_up.connect(adjust_camera)
	EnvSignals.magma_time.connect(kill_all)
	EnvSignals.contamination.connect(slow_all)
	EnvSignals.hostile.connect(spawn_killer_shark)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("exit") and self.visible:
		PlayerVariables.game_over.emit(false)


func _on_placeholder_end_pressed(): # SEÑAL DE EJEMPLO, DEBERÍA SER CUANDO SE MUERA EL PEZ
	self.hide()
	self.cleanup()


func start_game():
	self.show()

	var envModTimer = Spawner.SpawnTimer.new(EnvModifierClass, 1, 8)
	add_child(envModTimer)
	envModTimer.start_timer()
	
	pezTimer = Spawner.SpawnTimer.new(PezClass, 10, 2)
	add_child(pezTimer)
	pezTimer.start_timer()

	var pezRojoTimer = Timer.new()
	pezRojoTimer.timeout.connect(convert_red_fish)
	add_child(pezRojoTimer)
	pezRojoTimer.start(20)

	var minaTimer = Spawner.SpawnTimer.new(MinaClass, 3, 6)
	add_child(minaTimer)
	minaTimer.start_timer()

	var barrilTimer = Spawner.SpawnTimer.new(BarrilClass, 3, 6)
	add_child(barrilTimer)
	barrilTimer.start_timer()

	PlayerVariables.player_node = PlayerVariables.choose_player()
	add_child(PlayerVariables.player_node)

	add_child(BubbleCoralClass.instantiate())
	add_child(CofreClass.instantiate())
	add_child(SeaweedClass.instantiate())

	if PlayerVariables.control_mode != PlayerVariables.EYETRACKER:
		camera = Camera2D.new()
		camera.limit_left = 0
		camera.limit_top = 0
		camera.limit_right = ProjectSettings.get_setting('display/window/size/viewport_width')
		camera.limit_bottom = ProjectSettings.get_setting('display/window/size/viewport_height')
		camera.limit_smoothed = true
		camera.position_smoothing_enabled = true
		camera.zoom = PlayerVariables.camera_zoom * Vector2(1, 1)
		PlayerVariables.player_node.add_child(camera)

func kill_all():
	if is_instance_valid(pezTimer):
		var fish = pezTimer.get_children()
		for ch in fish:
			ch.disappear()
		PlayerVariables.eaten.emit(fish.size())

func slow_all(time):
	if is_instance_valid(pezTimer):
		for ch in pezTimer.get_children():
			ch.speed /= 2
			ch.get_node("Sprite2D/AnimationPlayer").speed_scale /= 2
			var timer = Timer.new()
			timer.timeout.connect(func ():
				ch.unslow()
				timer.queue_free()
			)
			timer.one_shot = true
			ch.add_child(timer)
			timer.start(time)


func spawn_killer_shark():
	if not PlayerVariables.hostile:
		PlayerVariables.hostile = true
		add_child(TiburonAsesinoClass.instantiate())

func adjust_camera(levels):
	if camera != null and PlayerVariables.level <= 5:
		camera.zoom -= Vector2(0.08, 0.08) * levels

func end_game(win):
	self.hide()
	self.cleanup()

func cleanup():
	for ch in get_children():
		ch.queue_free()

func convert_red_fish():
	var children = pezTimer.get_children()
	if children.size() > 0:
		children[randi() % children.size()].turn_red()
