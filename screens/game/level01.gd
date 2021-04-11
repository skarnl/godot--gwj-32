extends Node2D


var score = 0


func _ready():
	$Diamond.connect('pickup', self, 'on_diamond_pickup')
	$Diamond2.connect('pickup', self, 'on_diamond_pickup')
	$Diamond3.connect('pickup', self, 'on_diamond_pickup')
	$Diamond4.connect('pickup', self, 'on_diamond_pickup')
	$Diamond5.connect('pickup', self, 'on_diamond_pickup')
	$Diamond6.connect('pickup', self, 'on_diamond_pickup')
	$Diamond7.connect('pickup', self, 'on_diamond_pickup')
	
	$HUD.connect('continue', self, 'on_press_continue')
	
	set_process_input(false)

func on_diamond_pickup() -> void:
	print('player pick diamond - increase score')

	_increase_score()

func _increase_score() -> void:
	score += 1
	$HUD.update_score(score)

	if score == 7:
		$HUD.show_won()
		set_process_input(true)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		Game.goto_next_level()
