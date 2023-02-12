extends KinematicBody2D
var velocity = Vector2.ZERO
var mov = true
var gravity = 200;
func _physics_process(delta):
	velocity.y += gravity * delta

	if is_on_wall():
		mov = not mov
	if mov==true:
		velocity.x = 50
	else:
		velocity.x = -50


	velocity = move_and_slide(velocity,Vector2.UP)

func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		get_tree().reload_current_scene()

