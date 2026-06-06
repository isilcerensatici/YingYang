extends Area2D

@onready var manager = get_tree().current_scene.get_node("Bolum4Manager")

func _on_body_entered(body):
	if body.name.to_lower() == "yin1":
		manager.button2_pressed = true
		manager.check_buttons()

func _on_body_exited(body):
	if body.name.to_lower() == "yin1":
		manager.button2_pressed = false
