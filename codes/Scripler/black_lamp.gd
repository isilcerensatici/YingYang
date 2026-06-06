extends Area2D

@export var bolum8_manager: NodePath

var kullanildi := false

func _on_body_entered(body):
	if kullanildi:
		return

	if body.name.to_lower() == "yinfinal":
		kullanildi = true

		var manager = get_node_or_null(bolum8_manager)
		if manager != null:
			manager.start_black_phase()
