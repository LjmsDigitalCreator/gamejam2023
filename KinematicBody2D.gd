extends KinematicBody2D
var speed = 300;
var gravity = 200;
var velocity = Vector2.ZERO;
var max_speed = 150
var friction = 0.5
var resistance = 0.5
var timer
export(bool) var dashcomp : bool
var dash : bool  
export var cooldown = 3
onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var collision2 = $Area2D/CollisionShape2D
func norm():
	collision2.scale.x=1
	collision2.scale.y=1
	collision.scale.x=1
	sprite.scale.x=1
	collision.scale.y=1
	sprite.scale.y=1
func invc():
	collision2.scale.x=0
	collision2.scale.y=0
	sprite.scale.x=1
	sprite.scale.y=1
func big():
	collision2.scale.x=2
	collision2.scale.y=-2
	collision.scale.x=2
	sprite.scale.x=2
	collision.scale.y=-2
	sprite.scale.y=-2
func jump():
	velocity.y -= 300
func _physics_process(delta):
	var movement_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
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
