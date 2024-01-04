extends EnvModifier


var activated = false

func _ready():
	super()
	set_inside_spawn_pos([screen.x / 10, 9 * screen.x / 10], [9 * screen.y / 10, 7 * screen.y / 10])
	$Layer/PointLight2D.visible = false
	$Sprite2D.material.set_shader_parameter("line_thickness", 0)

func _on_interact_area_body_entered(body):
	if body is Player and activated == false:
		$Sprite2D.material.set_shader_parameter("line_thickness", 12)
		interactable = true

func _on_interact_area_body_exited(body):
	if body is Player:
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)
		interactable = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	if interactable and not activated and Input.is_action_just_pressed("interact"):
		magma_time()

func magma_time():
	FADE_SECONDS = 5
	activated = true
	EnvSignals.magma_time.emit()
	$Layer/PointLight2D.visible = true
	$AnimationPlayer.play("light_activation")
	$Sprite2D.material.set_shader_parameter("line_thickness", 0)

	# Poner mas tiempo, timer
	disappear()
