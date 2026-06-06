extends Area2D

@export var door: Node2D
var used := false

func _on_body_entered(body):
	if used:
		return

	if body.name.to_lower() == "yin":
		used = true
		if is_instance_valid(door):
			door.queue_free()
		queue_free()
