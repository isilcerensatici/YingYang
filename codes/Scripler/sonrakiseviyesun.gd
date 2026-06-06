extends Area2D

@export_file("*.tscn") var sonraki_seviye_yolu: String

var giren_oyuncu_sayisi := 0
var giren_oyuncular := []


func _on_body_entered(body):
	var ad = body.name.to_lower()

	if ad in ["yin", "yang", "yin1", "yang1", "blackpacman", "whitepacman", "yinfinal", "yangfinal", "bolum6yin", "bolum6yang"]:
		if body in giren_oyuncular:
			return

		giren_oyuncular.append(body)
		giren_oyuncu_sayisi += 1

		body.call_deferred("set_visible", false)
		body.call_deferred("set_physics_process", false)

		if giren_oyuncu_sayisi >= 2:
			get_tree().call_deferred("change_scene_to_file", sonraki_seviye_yolu)
