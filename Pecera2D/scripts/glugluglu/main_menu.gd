extends Control

func _on_jugar_pressed():
	self.hide()

func _on_salir_pressed():
	get_tree().quit()

func _on_modo_pressed():
	if PlayerVariables.control_mode == PlayerVariables.KEYBOARD:
		$MarginContainer/VBoxContainer/Modo.text = "Usar Ratón"
		$MarginContainer/VBoxContainer/Modo.icon = load("res://img/mouse.svg")
		PlayerVariables.control_mode = PlayerVariables.MOUSE
	elif PlayerVariables.control_mode == PlayerVariables.MOUSE:
		$MarginContainer/VBoxContainer/Modo.text = "Usar Eye Tracker"
		$MarginContainer/VBoxContainer/Modo.icon = load("res://img/eye.svg")
		PlayerVariables.control_mode = PlayerVariables.EYETRACKER
	elif PlayerVariables.control_mode == PlayerVariables.EYETRACKER:
		$MarginContainer/VBoxContainer/Modo.text = "Usar Teclado"
		$MarginContainer/VBoxContainer/Modo.icon = load("res://img/keyboard.svg")
		PlayerVariables.control_mode = PlayerVariables.KEYBOARD
