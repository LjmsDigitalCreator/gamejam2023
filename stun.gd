extends Node2D

func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		body.stop()
		yield(get_tree().create_timer(2), "timeout")
		body.stop()
		queue_free()
		
