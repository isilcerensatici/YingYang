extends Area2D

@export var fake_black_buttons: NodePath
@export var yin_cage: NodePath
@export var bolum7_manager: NodePath

var kullanildi := false

func _on_body_entered(body):
	if kullanildi:
		return

	if body.name.to_lower() == "yang":
		kullanildi = true

		var buttons = get_node_or_null(fake_black_buttons)
		if buttons != null:
			buttons.call_deferred("queue_free")

		var cage = get_node_or_null(yin_cage)
		if cage != null:
			cage.call_deferred("queue_free")

		var manager = get_node_or_null(bolum7_manager)
		if manager != null:
			print("Final fazı çağrılıyor")
			manager.start_fire_phase()
		else:
			print("HATA: Bolum7Manager bulunamadı")
