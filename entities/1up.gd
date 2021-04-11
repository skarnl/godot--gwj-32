extends Area2D

signal pickup

onready var animation_player = $AnimationPlayer
onready var animation = $AnimatedSprite
var hit: bool = false

func _on_body_entered(body: Node) -> void:
	if body.is_in_group('player') and not hit:
		hit = true
		
		emit_signal('pickup')
		
		animation_player.play('desolve')
		animation.play()
		
		yield(animation, 'animation_finished')
		
		queue_free()
