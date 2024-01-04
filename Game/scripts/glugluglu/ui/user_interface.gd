extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Layer.hide()
	PlayerVariables.eaten.connect(update_fish)
	PlayerVariables.damage.connect(take_damage)
	PlayerVariables.heal.connect(take_heal)
	PlayerVariables.xp_up.connect(func (xp):
		update_xp("add", xp)
	)

	update_heart_num("init", 3)
	update_xp("init", PlayerVariables.xp, PlayerVariables.level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_heart_num(method, num):
	match method:
		"init":
			PlayerVariables.health = num
		"add":
			if PlayerVariables.health < PlayerVariables.max_health:
				PlayerVariables.health += num
		"reduce":
			if PlayerVariables.health > 0:
				PlayerVariables.health -= num
	$Layer/Hearts.update_heart(PlayerVariables.health)

func update_xp(method, value, value2=1):
	match method:
		"init":
			$Layer/XP.setMaxValue(PlayerVariables.xp_max_value)
			$Layer/XP.setValue(value)
			$Layer/XP.setLevel(value2)
		"add":
			PlayerVariables.xp += value
			var levels = PlayerVariables.xp / PlayerVariables.xp_max_value
			if levels > 0:
				PlayerVariables.level += levels
				PlayerVariables.level_up.emit(levels)
			PlayerVariables.xp %= PlayerVariables.xp_max_value
			$Layer/XP.setValue(PlayerVariables.xp)
			$Layer/XP.setLevel(PlayerVariables.level)
		"clear":
			$Layer/XP.setValue(value)
			$Layer/XP.setLevel(value2)


func update_fish(count):
	PlayerVariables.fish_eaten += count
	$Layer/FishCount/Count.text = str(PlayerVariables.fish_eaten)
	update_xp("add", count * 10)

func take_damage():
	if not PlayerVariables.invulnerable:
		update_heart_num("reduce", 1)

	if PlayerVariables.health == 0:
		PlayerVariables.game_over.emit(false)

func take_heal():
	update_heart_num("add", 1)

func update_tutorial():
	if PlayerVariables.control_mode == PlayerVariables.MOUSE:
		$Layer/Tutorial/ComerTutorial/ComerInput.text = "CLICK IZQUIERDO"
		$Layer/Tutorial/InteractuarTutorial/InteractuarInput.text = "CLICK DERECHO"
	else:
		$Layer/Tutorial/ComerTutorial/ComerInput.text = "BARRA ESPACIADORA"
		$Layer/Tutorial/InteractuarTutorial/InteractuarInput.text = "SHIFT"

func restart():
	$Layer.show()
	$Layer/Tutorial/AnimationPlayer.stop()
	$Layer/Tutorial/AnimationPlayer.play("fade")
	update_tutorial()
