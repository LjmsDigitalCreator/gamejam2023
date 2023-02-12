extends KinematicBody2D
var speed = 300;
var gravity = 200;
var velocity = Vector2.ZERO;
var max_speed = 150
var friction = 0.5
var resistance = 0.5
var timer
var big : bool = false
export var cooldown = 3
onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var collision2 = $Area2D/CollisionShape2D
func norm():
	collision2.scale.x=1
	collision2.scale.y=1
	collision.scale.x=1
	sprite.scale.x=0.569
	collision.scale.y=1
	sprite.scale.y=0.569
	$Sprite2.scale.y=0.569
	$Sprite2.scale.x=0.569
func invc():
	collision2.scale.x=0
	collision2.scale.y=0
func big():
	collision2.scale.x=2.5
	collision2.scale.y=1.99
	collision.scale.x=2.5
	sprite.scale.x=1.70
	collision.scale.y=1.90
	sprite.scale.y=1
	$Sprite2.scale.y=1
	$Sprite2.scale.x=1.70
	big = true 
func jump():
	velocity.y -= 300
func _physics_process(delta):
	$Sprite/AnimationPlayer.play("Saltar")
	var movement_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if  Input.is_action_pressed("ui_left"):
		if big== true:
			sprite.scale.x=-1.70
			$Sprite2.scale.x=-1.70
		else:
			sprite.scale.x=-0.569
			$Sprite2.scale.x=-0.569
	if  Input.is_action_pressed("ui_right"):
		if big== true:
			sprite.scale.x=1.70
			$Sprite2.scale.x=1.70
		else:
			sprite.scale.x=0.569
			$Sprite2.scale.x=0.569
	if movement_x != 0:
		velocity.x += movement_x * speed * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y += gravity * delta
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
			$Sprite2.visible = true
			$Sprite.visible = false
			$Sprite/AnimationPlayer.stop(true)
			$Sprite2/AnimationPlayer.play("jump")
		else:
			$Sprite.visible = true
			$Sprite2.visible = false
			

	velocity.y += gravity * delta

	velocity = move_and_slide(velocity,Vector2.UP)

# warning-ignore:unused_argument
func _on_Area2D_area_entered(area):
	if area.is_in_group("power"):
		big()
		$Timer.start()
	if area.is_in_group("invencible"):
		invc()
		$Timer.start()
func _on_Timer_timeout():
	norm()
	big = false
