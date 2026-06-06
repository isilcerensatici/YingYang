extends Area2D

@export var door: Node
var used := false

func _on_body_entered(body):
	if used:
		return

	if body.name.to_lower() == "yang":
		used = true

		if is_instance_valid(door):
			door.open()

		queue_free()
