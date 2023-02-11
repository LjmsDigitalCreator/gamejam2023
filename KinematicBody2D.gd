extends KinematicBody2D

var speed = 300
var gravity = 300
var velocity = Vector2.ZERO
var max_speed = 150
var friction = 0.5
var resistance = 0.7

func jump():
	velocity.y -= 150

func _physics_process(delta):
	var movement_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if movement_x != 0:
		velocity.x += movement_x * speed * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
		
	if is_on_floor():
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, friction)
	else:
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, resistance)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			jump()
	
	
	
	velocity.y += gravity * delta

	velocity = move_and_slide(velocity, Vector2.UP)
