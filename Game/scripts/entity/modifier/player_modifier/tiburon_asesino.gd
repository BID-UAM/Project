extends Pez

class_name TiburonAsesino

const HOSTILE_SECONDS = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	var life_timer = Timer.new()
	life_timer.timeout.connect(self.disappear)
	add_child(life_timer)
	life_timer.start(HOSTILE_SECONDS)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	if not PlayerVariables.is_safe:
		target = PlayerVariables.player_node.global_position


func _on_body_entered(body):
	if body is Player and not PlayerVariables.invulnerable:
		PlayerVariables.damage.emit()
		new_target()
	elif body is Pez:
		body.disappear()


func _on_tree_exited():
	PlayerVariables.hostile = false
