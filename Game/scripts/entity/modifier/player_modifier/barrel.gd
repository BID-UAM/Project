extends RigidBody2D
signal isTouched()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		emit_signal("isTouched", self,body)
		queue_free()
	if(body.name=="floor"):
		await get_tree().create_timer(2.0).timeout
		queue_free()
	pass # Replace with function body.



