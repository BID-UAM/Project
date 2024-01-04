# Clase con funcionalidad de modficiadores del jugador (vida, XP, velocidad...)

extends Modifier

class_name PlayerModifier

var EFFECT_SECONDS = -1 # Si es mayor que 0, el efecto es temporal

# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)


func _on_body_entered(body):
	if body is Player and self.visible:
		self.hide()
		set_deferred('freeze', true)
		do_effect(body)

		if EFFECT_SECONDS > 0:
			var timer = Timer.new()
			timer.one_shot = true
			timer.timeout.connect(func():
				undo_effect(body)
				timer.queue_free()
				queue_free()
			)
			body.add_child(timer)
			timer.start(EFFECT_SECONDS)
		elif is_instance_valid(self):
			queue_free()

func do_effect(player):
	pass

func undo_effect(player):
	pass
