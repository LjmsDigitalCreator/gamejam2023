extends KinematicBody2D

var speed = 300
var gravity = 300
var velocity = Vector2.ZERO
var max_speed = 150
var resistance= 0.7
var friction=0.5
var change = true


func _physics_process(delta):
	
	if change == true:
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
		if change == true && gravity<0:
			if is_on_ceiling():
				if Input.is_action_just_pressed("ui_down"):
					velocity.y += 200
		else:
			if is_on_floor():
				if Input.is_action_just_pressed("ui_up"):
					velocity.y -= 200

	else:
		var movement_y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		if movement_y != 0:
			velocity.y += movement_y * speed * delta
			velocity.y = clamp(velocity.y, -max_speed, max_speed)
		if is_on_floor():
			if movement_y == 0:
				velocity.y= lerp(velocity.y, 0, friction)
		else:
			if movement_y == 0:
				 velocity.y = lerp(velocity.y, 0, resistance)
		if change == false && gravity<0:
			if is_on_wall():
				if Input.is_action_just_pressed("ui_right"):
					velocity.x += 200
		else:
			if is_on_wall():
				if Input.is_action_just_pressed("ui_left"):
					velocity.x -= 200
###################################################################################
	if  Input.is_action_just_pressed("ui_accionLateral"):
		CambioGravedadEnX()
	
	if change:
		velocity.y += gravity * delta
	else:
		velocity.x += gravity * delta
		
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_pressed("ui_accion"):
		CambioGravedadEnElEje()
func CambioGravedadEnElEje():
	gravity= gravity*(-1) 
	
func CambioGravedadEnX():
	if change:
			change = false
	else:
			change = true
