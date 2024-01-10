extends EnvModifier

var RemolinoClass = preload("res://escenas/env_state/remolino.tscn")

var pulling_out = false

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	set_inside_spawn_pos(Vector2(screen.x / 10, 9 * screen.x / 10), Vector2(9 * screen.y / 10, 8 * screen.y / 10))
	$Sprite2D.frame = 0
	FADE_SECONDS = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	if Input.is_action_just_pressed("interact") and interactable:
		pull_out()

	if pulling_out and not $Sprite2D/AnimationPlayer.is_playing():
		self.disappear()

func pull_out():
	if not $Sprite2D/AnimationPlayer.is_playing():
		freeze = false
		pulling_out = true
		$Sprite2D/AnimationPlayer.play("Sacar")


func _on_interact_area_body_entered(body):
	if body is Player:
		$Sprite2D.material.set_shader_parameter("line_thickness", 8)
		interactable = true


func _on_interact_area_body_exited(body):
	if body is Player:
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)
		interactable = false


func _on_tree_exited():
	var remolino = RemolinoClass.instantiate()
	remolino.global_position = self.global_position
	remolino.global_position.y -= 170
	parent.add_child.call_deferred(remolino)
	parent.move_child.call_deferred(remolino, 0)
