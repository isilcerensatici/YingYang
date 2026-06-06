extends Area2D

@onready var manager = get_tree().current_scene.get_node("Bolum4Manager")

var collected := false

func _on_body_entered(body):
	print("Key'e değen:", body.name)

	if collected:
		return

	if body.name.to_lower() == "yin1" or body.name.to_lower() == "yang1":
		collected = true
		print("Key toplandı")
		manager.key_collected()
		queue_free()
