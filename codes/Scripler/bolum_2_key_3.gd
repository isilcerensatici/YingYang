extends Area2D

var collected := false

func _on_body_entered(body):

	if collected:
		return

	if body.name.to_lower() == "yin" or body.name.to_lower() == "yang":

		collected = true

		get_parent().key_collected()

		queue_free()
