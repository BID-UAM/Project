extends Node2D

const KEYBOARD = 0
const MOUSE = 1

const CharacterDir = "res://escenas/player/characters/"

const max_health = 3
const xp_max_value = 100

signal eaten(count)
signal damage()
signal heal()
signal xp_up(xp)
signal level_up(levels)
signal game_over(win)

var health = 3
var xp = 0
var level = 0
var fish_eaten = 0

var player_node = null
var fish_selected = ""
var control_mode = MOUSE

var flee_active = false
var flee_distance = 50
var is_safe = false
var invulnerable = false
var invulnerability_seconds = 3
var hostile = false
var camera_zoom = 1.4

func reset_game():
	health = 3
	xp = 0
	level = 0
	fish_eaten = 0
	flee_distance = 20

	player_node = null
	fish_selected = ""
	is_safe = false
	invulnerable = false
	hostile = false
	camera_zoom = 1.4 

func choose_player():
	match fish_selected:
		'nemo':
			return preload(CharacterDir + "nemo.tscn").instantiate()
		'dory':
			return preload(CharacterDir + "dory.tscn").instantiate()
		'tortuga':
			return preload(CharacterDir + "tortuga.tscn").instantiate()
		'blinky':
			return preload(CharacterDir + "blinky.tscn").instantiate()
		'tiburon':
			return preload(CharacterDir + "tiburon.tscn").instantiate()

	return preload(CharacterDir + "nemo.tscn").instantiate()
