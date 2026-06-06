extends Area2D

func _on_body_entered(body):
	if body.name == "bolum6yang":
		get_parent().get_parent().get_node("Bolum6Manager").black_key_collected(self)
