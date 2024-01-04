extends HBoxContainer

@onready var heart_full = preload("res://img/ui/heart_full.svg")
@onready var heart_empty = preload("res://img/ui/heart_empty.svg")

func update_heart(value):
	for i in self.get_child_count():
		if i < value:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty
