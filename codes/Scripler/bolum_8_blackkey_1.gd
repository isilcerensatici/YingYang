extends Area2D

@export var bolum8_manager: NodePath

var toplandi := false

func _on_body_entered(body):
	if toplandi:
		return

	var ad = body.name.to_lower()

	if ad in ["yin", "yang", "yin1", "yang1", "blackpacman", "whitepacman", "yinfinal", "yangfinal"]:
		toplandi = true

		var manager = get_node_or_null(bolum8_manager)

		if manager != null:
			manager.key_collected()

		queue_free()
