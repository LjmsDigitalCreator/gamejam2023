extends KinematicBody2D

var speed = 400
var gravity = 300
var velocity = Vector2.ZERO
var max_speed = 200
var friction = 0.5
var resistance = 0.7
var stop=0
var low=0

func jump ():
	velocity.y -= 150
func Power_Up():
		speed += 400
		max_speed += 400
		yield(get_tree().create_timer(3), "timeout")
		speed = 400
		max_speed = 200
func Down_Up():
		speed -= 350
		max_speed -= 150
		yield(get_tree().create_timer(3), "timeout")
		speed = 400
		max_speed = 200

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
