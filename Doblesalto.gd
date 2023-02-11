extends Node2D

func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		body.dobble_jump = 1
		yield(get_tree().create_timer(5), "timeout")
		body.dobble_jump = 0
		queue_free()
		
