extends Area2D

@export var fake_black_buttons: NodePath

var kullanildi := false

func _ready():
	var buttons = get_node_or_null(fake_black_buttons)
	if buttons != null:
		buttons.visible = false
		buton_grubunu_kapat(buttons)


func _on_body_entered(body):
	if kullanildi:
		return

	if body.name.to_lower() == "yang":
		kullanildi = true

		var buttons = get_node_or_null(fake_black_buttons)
		if buttons != null:
			buttons.visible = true
			buton_grubunu_ac(buttons)

		queue_free()


func buton_grubunu_kapat(parent):
	for button in parent.get_children():
		for child in button.get_children():
			if child is CollisionShape2D:
				child.set_deferred("disabled", true)


func buton_grubunu_ac(parent):
	for button in parent.get_children():
		for child in button.get_children():
			if child is CollisionShape2D:
				child.set_deferred("disabled", false)
