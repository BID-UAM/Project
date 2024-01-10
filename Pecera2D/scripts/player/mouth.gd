extends Area2D

var BITE_FADE = 0.15
signal eaten()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bite.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Bite/AnimationPlayer.is_playing():
		if $Bite.modulate.a < 1:
			$Bite.modulate.a += delta / BITE_FADE

		if $Bite.frame > 2:
			var count_eaten = 0
			for body in get_overlapping_bodies():
				if body is TiburonAsesino:
					if PlayerVariables.level >= 5:
						PlayerVariables.eaten.emit(1)
						PlayerVariables.game_over.emit(true)
				elif body is Pez and not body.disappearing:
					body.disappear()
					body.get_node("CollisionShape2D").disabled = true
					body.speed = Vector2(50, 50)
					count_eaten += 1

			if count_eaten > 0:
				PlayerVariables.eaten.emit(count_eaten)

	elif $Bite.modulate.a > 0:
		$Bite.modulate.a -= delta / BITE_FADE
	else:
		$Bite.hide()
		$Bite.frame = 0


func bite():
	if not $Bite/AnimationPlayer.is_playing():
		$Bite.show()
		$Bite/AnimationPlayer.play("bite")
