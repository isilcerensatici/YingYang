extends Control

# Yeniden oyna denildiğinde oyuncunun döneceği yer (İster ana menüye, ister direkt Bölüm 1'e gönder)
@export_file("*.tscn") var ana_menu_yolu: String = "res://GirisMenu.tscn"

func _ready():
	# Bölüm bittiğinde mouse imleci gizlendiyse menüde tekrar görünür yapıyoruz
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_btn_yeniden_pressed() -> void:
	# Yeniden oyna butonuna basıldığında ana menüye (veya Bölüm 1'e) döner
	get_tree().change_scene_to_file("res://Sahneler/AnaSahne.tscn")

func _on_btn_cikis_pressed() -> void:
	# Oyundan tamamen çıkar
	get_tree().quit()
