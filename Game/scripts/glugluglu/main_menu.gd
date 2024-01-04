extends Control

@export var mode: String = ""

func _on_un_jugador_pressed():
	mode = "Singleplayer"
	self.hide()

func _on_multijugador_pressed():
	mode = "Multiplayer"
	OS.alert("Modo multijugador aún no está implementado", "¡No implementado!")

func _on_salir_pressed():
	get_tree().quit()

func _on_modo_pressed():
	if PlayerVariables.control_mode == PlayerVariables.MOUSE:
		$MarginContainer/VBoxContainer/Modo.text = "Usar Teclado"
		$MarginContainer/VBoxContainer/Modo.icon = load("res://img/keyboard.svg")
		PlayerVariables.control_mode = PlayerVariables.KEYBOARD
	else:
		$MarginContainer/VBoxContainer/Modo.text = "Usar Ratón"
		$MarginContainer/VBoxContainer/Modo.icon = load("res://img/mouse.svg")
		PlayerVariables.control_mode = PlayerVariables.MOUSE
