extends Area2D

@export var fake_white_buttons: NodePath
@export var yang_cage: NodePath
@export var yin_cage: NodePath
@export var real_black_button: NodePath

var kullanildi := false

func _ready():
	kafesi_kapat(yin_cage)
	real_black_button_kapat()


func _on_body_entered(body):
	if kullanildi:
		return

	if body.name.to_lower() == "yin":
		kullanildi = true

		var buttons = get_node_or_null(fake_white_buttons)
		if buttons != null:
			buttons.call_deferred("queue_free")

		var yang_kafes = get_node_or_null(yang_cage)
		if yang_kafes != null:
			yang_kafes.call_deferred("queue_free")

		kafesi_ac(yin_cage)
		real_black_button_ac()


func kafesi_kapat(cage_path: NodePath):
	var cage = get_node_or_null(cage_path)
	if cage == null:
		return

	cage.visible = false

	for child in cage.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", true)


func kafesi_ac(cage_path: NodePath):
	var cage = get_node_or_null(cage_path)
	if cage == null:
		return

	cage.visible = true

	for child in cage.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", false)


func real_black_button_kapat():
	var button = get_node_or_null(real_black_button)
	if button == null:
		return

	button.visible = false

	for child in button.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", true)


func real_black_button_ac():
	var button = get_node_or_null(real_black_button)
	if button == null:
		return

	button.visible = true

	for child in button.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", false)
