extends CanvasLayer

func _ready() -> void:
	$Won.hide()
	$DiedMessage.hide()
	$Score.show()
	
	reset_score()


func update_score(score: int) -> void:
	$Score.text = str(score)
	$Explode.restart()


func reset_score() -> void:
	$Score.text = str(0)


func show_died() -> void:
	$DiedMessage.show()
	
	
func hide_died() -> void:
	$DiedMessage.hide()
	

func show_won() -> void:
	$DiedMessage.hide()
	$Score.hide()
	$Won/WonExplosion.emitting = true
	$Won.show()
