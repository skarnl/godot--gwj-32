extends Node2D

var PlusPrefab = preload('../../entities/1up.tscn')

var score = 0
var lives = 0


var initial_plus_position = Vector2.ZERO
var initial_player_position = Vector2.ZERO
var plus_ref

func _ready():
	$Plus.connect('pickup', self, '_on_player_pickup_plus')
	$KillZone.connect('body_entered', self, 'on_player_entered')
	
	initial_plus_position = $Plus.position
	initial_player_position = $Player.position
	
	plus_ref = $Plus
	
	set_process_input(false)
	
	
func on_player_entered(body: CollisionObject2D) -> void:
	if body and body.is_in_group('player'):
		
		print("HIT - lives = ", lives)
		
		if lives > 0:
			lives = lives - 1
			increase_score()
		else:
			score = 0
			$HUD.reset_score()

		print("HIT - lives = ", lives)

		kill_player()
	

func increase_score():
	score += 1
	
	$HUD.update_score(score)

	if score == 7:
		$HUD.show_won()
		set_process_input(true)


func kill_player():
	$Player.disable()
	$Player.hide()
	$HUD.show_died()
	
	yield(get_tree().create_timer(3.0), "timeout")
	
	$HUD.hide_died()
	
	$Player.position = initial_player_position
	$Player.show()
	$Player.enable()
	
	if plus_ref:
		plus_ref.queue_free()
	
	plus_ref = PlusPrefab.instance()
	plus_ref.position = initial_plus_position
	plus_ref.connect('pickup', self, '_on_player_pickup_plus')
	add_child(plus_ref)
	

func _on_player_pickup_plus() -> void:
	print("before pickup - lives = ", lives)
	lives += 1
	print("after pickup - lives = ", lives)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		Game.goto_next_level()
