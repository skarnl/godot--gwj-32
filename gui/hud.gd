extends CanvasLayer

signal won


var score = 0


func _ready() -> void:
	$WonLabel.hide()
	$WonExplosion.hide()
	$DiedMessage.hide()
	$Score.show()


func reset_score() -> void:
	score = 0
	update_score()
	

func increase_score() -> void:
	score += 1
	$Explode.restart()
	update_score()
	
	if score == 7:
		emit_signal('won')
		show_won()
	

func update_score() -> void:
	$Score.text = str(score)


func show_died() -> void:
	$DiedMessage.show()
	$Score.hide()


func show_won() -> void:
	$DiedMessage.hide()
	$Score.hide()
	$WonLabel.show()
	$WonExplosion.show()
	$WonExplosion.emitting = true
