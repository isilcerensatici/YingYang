extends Area2D

@export var bolum8_manager: NodePath

var basildi := false

func _on_body_entered(body):
	if basildi:
		return

	if body.name.to_lower() == "yinfinal":
		basildi = true

		var manager = get_node_or_null(bolum8_manager)
		if manager != null:
			manager.white_final_button_pressed()
