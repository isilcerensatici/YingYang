extends Control

# Oyuna başlandığında gideceği ilk bölümün yolu
# Projendeki Bölüm 1'in gerçek adıyla değiştir: "res://Bolum1.tscn" gibi.
@export var baslangic_bolumu_yolu: String = "res://Sahneler/AnaSahne.tscn"

func _on_btn_basla_pressed() -> void:
	# Oyuna başla butonuna basıldığında
	get_tree().change_scene_to_file(baslangic_bolumu_yolu)

func _on_btn_cikis_pressed() -> void:
	# Çıkış butonuna basıldığında
	get_tree().quit()
