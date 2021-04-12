extends Node2D

var score = 0


var initial_player_position = Vector2.ZERO

func _ready():
	$KillZone.connect('body_entered', self, 'on_player_entered')
	
	initial_player_position = $Player.position
	
	set_process_input(false)
	
	
func on_player_entered(body: CollisionObject2D) -> void:
	if body and body.is_in_group('player'):
		if !increase_score():
			kill_player()
	

func increase_score() -> bool:
	score += 1
	
	$HUD.update_score(score)

	if score == 7:
		$HUD.show_won()
		set_process_input(true)
		return true
	
	return false


func kill_player():
	$Player.disable()
	$Player.hide()
	$HUD.show_died()
	
	yield(get_tree().create_timer(1.5), "timeout")
	
	$HUD.hide_died()
	
	$Player.position = initial_player_position
	$Player.show()
	$Player.enable()
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		Game.goto_next_level()
