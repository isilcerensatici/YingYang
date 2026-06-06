extends Area2D

func _on_body_entered(body):
	if body.name == "bolum6yin":
		get_parent().get_parent().get_node("Bolum6Manager").white_key_collected(self)
