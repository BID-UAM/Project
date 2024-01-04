extends Control

const PTS_PER_FISH = 50
const PTS_PER_LVL = 500
const PTS_VICTORY = 5000

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVariables.game_over.connect(set_end_screen)
	$GridContainer/VictoriaPoints.text = String.num(PTS_VICTORY) + " PTS"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_to_menu_pressed():
	self.hide()

func set_end_screen(win):
	var final_score = PlayerVariables.fish_eaten * PTS_PER_FISH + PTS_PER_LVL * PlayerVariables.level
	if win:
		final_score += PTS_VICTORY
		$RichTextLabel.parse_bbcode("[center]¡Has Ganado!")
		$GridContainer/VictoriaLabel.show()
		$GridContainer/VictoriaPlaceholder.show()
		$GridContainer/VictoriaPoints.show()
		$GridContainer.add_theme_constant_override("v_separation", 70)
	else:
		$RichTextLabel.parse_bbcode("[center]¡Has Perdido!")
		$GridContainer/VictoriaLabel.hide()
		$GridContainer/VictoriaPlaceholder.hide()
		$GridContainer/VictoriaPoints.hide()
		$GridContainer.add_theme_constant_override("v_separation", 90)

	$GridContainer/PecesPoints.text = "X      %d PTS" % PTS_PER_FISH
	$GridContainer/NivelPoints.text = "X    %d PTS" % PTS_PER_LVL
	$GridContainer/PecesNumero.text = String.num(PlayerVariables.fish_eaten)
	$GridContainer/NivelNumero.text = String.num(PlayerVariables.level)
	$GridContainer/FinalPoints.text = String.num(final_score)\
	 + " PTS"
