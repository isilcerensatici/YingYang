extends Area2D

@onready var manager = get_tree().current_scene.get_node("Bolum3Manager")

func _on_body_entered(body):
	if body.name.to_lower() == "yin":
		manager.make_black()
		queue_free()
