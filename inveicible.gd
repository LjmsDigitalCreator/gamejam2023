extends Node2D


func _on_Area2D_area_entered(body):
	if body.is_in_group("player"):
		queue_free()
