extends PlayerModifier

class_name Pez

var target = Vector2(0, 0)
@export var speed  = Vector2(200, 200)

var max_scale: float
var red_fish = false

func new_target():
	target.x = randf_range(screen.x/10, screen.x*9/10)
	target.y = randf_range(screen.y/10, screen.y*9/10)

var angular_force = 50000

func turn_to_position():
	var dir = target - global_position
	var tmp_rotation = dir.angle()
	
	var sprite_rotation = rad_to_deg(rotation)
	var new_rotation = rad_to_deg(tmp_rotation)
	
	# check_rotation_diff(new_rotation)
	# No rotar cuando hay poca distancia entre el ratón
	var distance = dir.length()
	if distance < 1:
		tmp_rotation = rotation

	if rotation_degrees > 90 or rotation_degrees < -90:
		$Sprite2D.flip_v = true;
	else:
		$Sprite2D.flip_v = false;

	rotation = tmp_rotation
	
	return dir

func simple_turn(amount):
	if global_position.y < target.y:
		$Sprite2D.rotation_degrees = 15
	elif global_position.y > target.y:
		$Sprite2D.rotation_degrees = -15
	else:
		$Sprite2D.rotation_degrees = 0

	if global_position.x < target.x and $Sprite2D.scale.x < max_scale:
		$Sprite2D.scale.x += amount
	elif global_position.x > target.x and $Sprite2D.scale.x > -max_scale:
		$Sprite2D.scale.x -= amount

	if global_position.x == target.x and abs($Sprite2D.scale.x) < max_scale:
		if $Sprite2D.scale.x >= 0:
			$Sprite2D.scale.x += amount
		elif $Sprite2D.scale.x < 0:
			$Sprite2D.scale.x -= amount
	
	if $Sprite2D.scale.x < 0:
		$Sprite2D.rotation_degrees *= -1

#func move(delta):
#	var movement
#
#	if global_position.x < target.x:
#		movement = speed.x * delta
#		if global_position.x + movement >= target.x:
#			global_position.x = target.x
#		else:
#			global_position.x += movement
#	elif global_position.x > target.x:
#		movement = speed.x * delta
#		if global_position.x - movement <= target.x:
#			global_position.x = target.x
#		else:
#			global_position.x -= movement
#
#	if global_position.y < target.y:
#		movement = speed.y * delta
#		if global_position.y + movement >= target.y:
#			global_position.y = target.y
#		else:
#			global_position.y += movement
#	elif global_position.y > target.y:
#		movement = speed.y * delta
#		if global_position.y - movement <= target.y:
#			global_position.y = target.y
#		else:
#			global_position.y -= movement

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	set_outside_spawn_pos(true, true, true, false)
	FADE_SECONDS = 0.75
	new_target()
	max_scale = $Sprite2D.scale.x

func _physics_process(delta):

	# Huir del jugador
	if PlayerVariables.flee_active and abs(global_position.length() - PlayerVariables.player_node.global_position.length()) < PlayerVariables.flee_distance:
		target = global_position + (global_position - PlayerVariables.player_node.global_position)

	linear_velocity = (target - global_position).normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

	if abs(global_position.length() - target.length()) < 2:
		new_target()

#	turn_to_position()
	simple_turn(max_scale/10)


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass

func unslow():
	speed *= 2
	$Sprite2D/AnimationPlayer.speed_scale *= 2

func disappear():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.hide()
	$Death.show()
	if $Sprite2D.scale.x < 0:
		$Death.scale.x = -$Death.scale.x
	$Death/DeathPlayer.play("dead")
	if red_fish:
		EnvSignals.hostile.emit()
	super()

func turn_red():
	red_fish = true
	$Sprite2D.material.set_shader_parameter("line_thickness", 10)

