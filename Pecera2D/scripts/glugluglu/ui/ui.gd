extends Control

var current_heart
const MaxHeart=3
var ep_level=1
var ep_value=0
const ep_max_value=100

func update_heart_num(method,num):
	match method:
		"init":
			current_heart=num
		"add":
			if(current_heart<MaxHeart):
				current_heart+=num
		"reduce":
			if(current_heart>0):
				current_heart-=num
	$Heart.update_heart(current_heart)

func update_xp(method, value, value2=1):
	match method:
		"init":
			$XP.setMaxValue(ep_max_value)
			$XP.setValue(value)
			$XP.setLevel(value2)
		"add":	
			ep_value+=value
			ep_level+=ep_value/ep_max_value
			ep_value=ep_value%ep_max_value
			$XP.setValue(ep_value)
			$XP.setLevel(ep_level)
		"clear":
			$XP.setValue(value)
			$XP.setLevel(value2)

func _ready():
	update_heart_num("init",3)
	update_xp("init",ep_value,ep_level)
	update_xp("add",400)


#Inicializar el volumen de sangre, hasta 3 corazones
#update_heart_num("init",3)
#Aumentar el volumen de sangre
#update_heart_num("add",1)
#Reducir el volumen de sangre
#update_heart_num("reduce",1)
#Inicializar el valor de la experiencia y el nivel actual
#update_xp("init",ep_value,ep_level)
#Aumentar los puntos de experiencia.
#update_xp("add",400)
