extends Node2D

@onready var background = $"../BackgroundColor"
@onready var blue_button = $"../BlueButton"

@onready var key1 = $"../bolum3key1"
@onready var key2 = $"../bolum3key2"
@onready var key3 = $"../bolum3key3"
@onready var key4 = $"../bolum3key4"

@onready var sun = $"../sonrakiseviyesun"

var collected_keys := 0

func _ready():
	sun.visible = false
	sun.get_node("CollisionShape2D").set_deferred("disabled", true)

func make_black():
	background.color = Color.BLACK
	blue_button.visible = true
	blue_button.get_node("CollisionShape2D").set_deferred("disabled", false)

func make_blue():
	background.color = Color("87CEEB")
	show_keys()

func show_keys():
	for key in [key1, key2, key3, key4]:
		key.visible = true
		key.get_node("CollisionShape2D").set_deferred("disabled", false)

func key_collected():
	collected_keys += 1

	if collected_keys >= 4:
		sun.visible = true
		sun.get_node("CollisionShape2D").set_deferred("disabled", false)
