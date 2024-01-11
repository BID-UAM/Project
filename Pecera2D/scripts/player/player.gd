extends CharacterBody2D

class_name Player

var pos: Vector2 = Vector2.ONE * 200
var max_speed = 400  # Ajusta este valor para cambiar la velocidad máxima
var delta_accum = 0

var max_distance_accel = 300
var mid_distance_accel = 200
var min_distance_accel = 100

var max_scale

var rng = RandomNumberGenerator.new()
var screen = DisplayServer.window_get_size()
var eyeTarget

var change_trajectory = false
var has_bite = false

# Called when the node enters the scene tree for the first time.

func _ready():
	position.x = rng.randf_range(0,screen.x)
	position.y = rng.randf_range(0,screen.y)

	max_scale = $Skin.scale.x
	set_meta('default_modulate_r', $Skin.modulate.r)
	has_bite = $Skin/AnimationPlayer.has_animation('bite')

	PlayerVariables.damage.connect(take_damage)
	PlayerVariables.level_up.connect(level_up)
	
	if PlayerVariables.control_mode == PlayerVariables.EYETRACKER:
		eyeTarget = $"../../User Interface/Layer/PeceraEyetracker"
		max_speed = 500
		mid_distance_accel = 100
		min_distance_accel = 50

func _process(delta):
	if PlayerVariables.control_mode == PlayerVariables.KEYBOARD:
		process_keyboard_movement(delta)
	elif PlayerVariables.control_mode == PlayerVariables.MOUSE:
		process_target_movement(get_global_mouse_position(), delta)
	elif PlayerVariables.control_mode == PlayerVariables.EYETRACKER:
		if eyeTarget.is_winking():
			Input.action_press("interact")
			Input.action_release("interact")
		if eyeTarget.is_double_blinking():
			Input.action_press("bite")
			Input.action_release("bite")
		process_target_movement(eyeTarget.get_coordinates(), delta)

	if Input.is_action_just_pressed("bite"):
		if has_bite:
			$Skin/AnimationPlayer.play("bite")
		$Skin/Mouth.bite()

	if (position.x <= 0 || position.x >= screen.x):
		position.x = clamp(position.x, 0, screen.x)
	if (position.y <= 0 || position.y >= screen.y):
		position.y = clamp(position.y, 0, screen.y)

	if PlayerVariables.invulnerable:
		$Skin.modulate.a = fmod($Skin.modulate.a + delta * 2, 1.0)
	else:
		$Skin.modulate.a = 1


func turn_to_target(target):
	var dir = target - global_position
	var tmp_rotation = dir.angle()
	
	var sprite_rotation = rad_to_deg(rotation)
	var new_rotation = rad_to_deg(tmp_rotation)
	
	check_rotation_diff(new_rotation)
	# No rotar cuando hay poca distancia entre el ratón
	var distance = dir.length()
	if distance < 1:
		tmp_rotation = rotation
	
	rotation = tmp_rotation
	
	return dir

	
func check_rotation_diff(new_rot: float):
	
	var actual_trajectory = rad_to_deg(velocity.angle())
	
	var rot_diff = abs(abs(new_rot) - abs(actual_trajectory))

	if rot_diff > 35:
		velocity *= 0.95

func process_target_movement(target, delta):
	var dir = turn_to_target(target)
	
	var distance = dir.length()
	
	var acceleration
	if distance > max_distance_accel:  # Ajusta estos valores para cambiar las regiones de distancia
		acceleration = 400  # Aceleración alta
	if distance > mid_distance_accel:  # Ajusta estos valores para cambiar las regiones de distancia
		acceleration = 300  # Aceleración alta
	elif distance > min_distance_accel:
		acceleration = 200  # Aceleración media
	else:
		acceleration = 100  # Aceleración baja

	if $Skin/AnimationPlayer.current_animation != "bite":
		if acceleration > 100:
			$Skin/AnimationPlayer.play("swim")
		else:
			$Skin/AnimationPlayer.play("idle")

	# Aplica una fuerza en la dirección del ratón
	velocity += dir.normalized() * acceleration * delta

	# Limita la velocidad al máximo
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	
	# Si el sprite está cerca del ratón, reduce la velocidad progresivamente
	if distance < 150:  # Ajusta este valor para cambiar la distancia de frenado
		velocity *= 0.94  # Ajusta este valor para cambiar la rapidez de frenado

	if rotation_degrees > 90 or rotation_degrees < -90:
		$Skin.flip_v = true
		$Skin/Mouth/Bite.flip_v = true
	else:
		$Skin.flip_v = false
		$Skin/Mouth/Bite.flip_v = false

	# Aplica la velocidad al sprite
	move_and_slide()

func process_keyboard_movement(delta):
	var direction: Vector2 = Vector2(
		Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	var amount = max_scale/10

	if direction.y == 1:
		$Skin.rotation_degrees = 15
	elif direction.y == -1:
		$Skin.rotation_degrees = -15
	else:
		$Skin.rotation_degrees = 0

	if direction.x == 1 and $Skin.scale.x < max_scale:
		$Skin.scale.x += amount
	elif direction.x == -1 and $Skin.scale.x > -max_scale:
		$Skin.scale.x -= amount

	if not direction.x and abs($Skin.scale.x) < max_scale:
		if $Skin.scale.x >= 0:
			$Skin.scale.x += amount
		elif $Skin.scale.x < 0:
			$Skin.scale.x -= amount

	if $Skin.scale.x < 0:
		$Skin.rotation_degrees *= -1

	if direction.x:
		velocity.x = direction.x * max_speed
	else:
		velocity.x = move_toward(velocity.x, 0, max_speed)
	if direction.y:
		velocity.y = direction.y * max_speed
	else:
		velocity.y = move_toward(velocity.y, 0, max_speed)

	if not direction:
		delta_accum = fmod(delta_accum + delta*3, 2*PI)
		global_position.y = global_position.y + sin(delta_accum) / 4
		$Skin/AnimationPlayer.play("idle")
	else:
		$Skin/AnimationPlayer.play("swim")

	move_and_slide()

func level_up(levels):
	if PlayerVariables.level <= 5:
		Util.set_scale(Vector2(1, 1) + Vector2(1, 1) * PlayerVariables.level * 0.4, self)
		PlayerVariables.flee_distance += levels * 10

func take_damage():
	if not PlayerVariables.invulnerable:
		PlayerVariables.invulnerable = true

		var timer = Timer.new()
		timer.one_shot = true
		timer.timeout.connect(func ():
			PlayerVariables.invulnerable = false
			timer.queue_free()
		)
		add_child(timer)
		timer.start(PlayerVariables.invulnerability_seconds)
