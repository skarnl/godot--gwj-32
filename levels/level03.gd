extends Node2D

var PlusPrefab = preload('../entities/plus.tscn')

var score = 0


var initial_plus_position = Vector2.ZERO
var initial_player_position = Vector2.ZERO
var plus_ref

func _ready():
	$KillZone.connect('body_entered', self, 'on_player_entered')
	
	initial_plus_position = $Plus.position
	initial_player_position = $Player.position
	
	$Plus.queue_free()
	
	add_plus()
	
	set_process_input(false)

func add_plus() -> void:
	if plus_ref == null:
		plus_ref = PlusPrefab.instance()
		plus_ref.position = initial_plus_position
		plus_ref.connect('pickup', self, '_on_player_pickup_plus')
		add_child(plus_ref)

	
func on_player_entered(body: CollisionObject2D) -> void:
	if body and body.is_in_group('player'):
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
	
	yield(get_tree().create_timer(1.5), "timeout")
	
	$HUD.hide_died()
	
	add_plus()
	
	$Player.position = initial_player_position
	$Player.show()
	$Player.enable()
	

func _on_player_pickup_plus() -> void:
	plus_ref = null
	increase_score()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		Game.goto_next_level()
