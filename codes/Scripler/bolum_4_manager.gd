extends Node2D

@onready var button1 = $"../bolum4button1"
@onready var button2 = $"../bolum4button2"
@onready var platform = $"../PlatformTileMap"
@onready var sun = $"../sonrakiseviyesun"
@onready var acid_timer = $"../AcidTimer"
@onready var acid_spawn_timer = $"../AcidSpawnTimer"

var acid_scene = preload("res://Sahneler/acid_drop.tscn")

var collected_keys := 0
var button1_pressed := false
var button2_pressed := false
var acid_started := false


func _ready():

	button1.visible = false
	button2.visible = false

	button1.get_node("CollisionShape2D").set_deferred("disabled", true)
	button2.get_node("CollisionShape2D").set_deferred("disabled", true)

	sun.visible = false
	sun.get_node("CollisionShape2D").set_deferred("disabled", true)


func key_collected():

	collected_keys += 1

	if collected_keys >= 2:

		button1.visible = true
		button2.visible = true

		button1.get_node("CollisionShape2D").set_deferred("disabled", false)
		button2.get_node("CollisionShape2D").set_deferred("disabled", false)


func check_buttons():

	if acid_started:
		return

	if button1_pressed and button2_pressed:

		acid_started = true

		button1.queue_free()
		button2.queue_free()

		platform.visible = false

		for i in range(platform.get_layers_count()):
			platform.set_layer_enabled(i, false)

		# 2 saniye bekle
		await get_tree().create_timer(2.0).timeout

		acid_timer.start()
		acid_spawn_timer.start()

		print("Asit aşaması başladı")


func _on_acid_spawn_timer_timeout():

	for i in range(3):

		var acid = acid_scene.instantiate()

		get_tree().current_scene.add_child(acid)

		acid.position = Vector2(
			randf_range(0,1280),
			-50
		)


func _on_acid_timer_timeout():

	acid_spawn_timer.stop()

	platform.visible = true

	for i in range(platform.get_layers_count()):
		platform.set_layer_enabled(i, true)

	sun.visible = true
	sun.get_node("CollisionShape2D").set_deferred("disabled", false)

	print("Asit bitti, platform ve güneş geldi")
