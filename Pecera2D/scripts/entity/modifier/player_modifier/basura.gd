extends PlayerModifier

class_name Basura

var collision

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	$Sprite2D.frame = rng.randi_range(0, 4)
	match $Sprite2D.frame:
		0:
			collision = $CollisionShape2D
		1:
			collision = $CollisionShape2D2
		2:
			collision = $CollisionShape2D3
		3, 4:
			collision = $CollisionShape2D4
	collision.disabled = false

	var boat = get_node_or_null("../../BarcoEnvState/Barco")
	if boat:
		global_position.x = boat.global_position.x
	global_position.y = 10

	EFFECT_SECONDS = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)


func do_effect(player):
	player.get_node("Skin").modulate.r /= 2
	player.get_node("Skin/AnimationPlayer").speed_scale /= 2
	player.max_speed /= 2

func undo_effect(player):
	player.get_node("Skin").modulate.r = min(2 * player.get_node("Skin").modulate.r, player.get_meta('default_modulate_r'))
	player.get_node("Skin/AnimationPlayer").speed_scale *= 2
	player.max_speed *= 2

func _on_visible_on_screen_notifier_2d_screen_exited():
	if not freeze:
		queue_free()
