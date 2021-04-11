
extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO
var MAX_SPEED = 210
var ACCELERATION = 1000
var FRICTION = 600

var target_position: Vector2 = Vector2.ZERO
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		input_vector = get_viewport().get_mouse_position() - position
		input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		apply_movement(input_vector * ACCELERATION * delta)
	else:
		apply_friction(FRICTION * delta)
		
	velocity = move_and_slide(velocity)
	
func apply_movement(acceleration):
	velocity += acceleration
	velocity = velocity.clamped(MAX_SPEED)
	
func apply_friction(friction):
	if velocity.length() > friction:
		velocity -= velocity.normalized() * friction
	else:
		velocity = Vector2.ZERO
