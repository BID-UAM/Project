extends PlayerModifier

class_name Seaweed

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	set_inside_spawn_pos([screen.x / 10, 9 * screen.x / 10], [7.5 * screen.y / 10, 9 * screen.y / 10])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)


func _on_area_2d_body_entered(body):
	if body is Player:
		$Sprite2D.material.set_shader_parameter("line_thickness", 2.5)
		PlayerVariables.is_safe = true


func _on_area_2d_body_exited(body):
	if body is Player:
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)
		PlayerVariables.is_safe = false
