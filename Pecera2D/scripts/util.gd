class_name Util

static func get_player(tree):
	for node in tree.get_children():
		if node is Player:
			return node
		else:
			var child_player = get_player(node)
			if child_player:
				return child_player
	return null

static func unfade(delta, item, fade_seconds=null):
	# Fade effect when appearing	
	if item.modulate.a < 1:
		item.modulate.a += delta / (fade_seconds if fade_seconds else item.FADE_SECONDS)

static func fade(delta, item, fade_seconds=null):
	# Fade effect when appearing	
	if item.modulate.a > 0:
		item.modulate.a -= delta / (fade_seconds if fade_seconds else item.FADE_SECONDS)
	else:
		item.queue_free()

static func grow(delta, item, original_scale, fade_seconds):
	if item.scale < original_scale:
		item.scale += original_scale * delta / fade_seconds
	
static func shrink(delta, item, original_scale, fade_seconds):
	if item.scale > Vector2(0, 0):
		item.scale -= original_scale * delta / fade_seconds

static func set_scale(scale, node):
	# Override behaviour only if it is a RigidBody2D and do not touch other nodes
	if node is RigidBody2D:
		for child in node.get_children():
			if not child.has_meta("original_scale"):
				# save original scale and position as a reference for future modifications
				child.set_meta("original_scale", child.get_scale())
				child.set_meta("original_pos", child.get_pos())
			var original_scale = child.get_meta("original_scale")
			var original_pos = child.get_meta("original_pos")
			# When scaled, position also has to be changed to keep offset
			child.set_pos(original_pos * scale)
			child.set_scale(original_scale * scale)
	else:
		node.set_scale(scale)
