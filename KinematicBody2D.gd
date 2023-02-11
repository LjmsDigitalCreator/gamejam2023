extends KinematicBody2D

var speed = 300
var gravity = 300
var velocity = Vector2.ZERO
var max_speed = 150
var resistance =0.7
var friction = 0.5
var dobble_jump = 0
var detenido = 0

func move():
	speed=300
	max_speed=150
	
func stop():
	if detenido == 0:
		speed=0
		max_speed=0
		detenido=1
	else:
		speed=300
		max_speed=150
		detenido=0

func Jump():
	velocity.y -= 150
	
	
func Doble_Jump():
	velocity.y -= 250
	

func _physics_process(delta): 
	var movement_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement_x != 0:
		velocity.x += movement_x * speed * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed) 
	
	if Input.is_action_just_pressed("ui_accept"):
		stop()
		
	if is_on_floor():
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, friction)
	else:
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, resistance)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			Jump()
	else:
		if Input.is_action_just_pressed("ui_up"):
			if dobble_jump == 1:
				Doble_Jump()
	velocity.y += gravity * delta

	velocity = move_and_slide(velocity,Vector2.UP)

	
	velocity.y += gravity * delta

	velocity = move_and_slide(velocity,Vector2.UP)
	
