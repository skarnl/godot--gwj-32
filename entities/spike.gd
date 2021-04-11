extends Area2D

signal hit_player

func _on_body_entered(body: Node) -> void:
	if body.is_in_group('player'):
		emit_signal('hit_player')
