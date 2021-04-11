extends Node2D

func _ready():
	$HUD.reset_score()
	
	$Diamond.connect('pickup', self, 'on_diamond_pickup')
	$Diamond2.connect('pickup', self, 'on_diamond_pickup')
	$Diamond3.connect('pickup', self, 'on_diamond_pickup')
	$Diamond4.connect('pickup', self, 'on_diamond_pickup')
	$Diamond5.connect('pickup', self, 'on_diamond_pickup')
	$Diamond6.connect('pickup', self, 'on_diamond_pickup')
	$Diamond7.connect('pickup', self, 'on_diamond_pickup')

func on_diamond_pickup() -> void:
	print('player pick diamond - increase score')

	$HUD.increase_score()
