extends EnvModifier

const CONTAMINATION_SECONDS = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	global_position.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func _on_body_entered(body):
	if body is Player:
		if not PlayerVariables.invulnerable:
			PlayerVariables.damage.emit()
		EnvSignals.contamination.emit(CONTAMINATION_SECONDS)
		if is_instance_valid(self):
			self.hide()
			$ParallaxBackground.show()
			var timer = Timer.new()
			timer.timeout.connect(func ():
				timer.queue_free()
				queue_free()
			)
			add_child(timer)
			timer.start(CONTAMINATION_SECONDS)
