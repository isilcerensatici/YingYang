extends Node2D

@onready var all_platforms = $"../AllPlatforms"
@onready var fire_timer = $"../FireTimer"
@onready var fire_spawn_timer = $"../FireSpawnTimer"
@onready var sun = $"../sonrakiseviyesun"

var fire_scene = preload("res://Sahneler/fire_drop.tscn")

func _ready():
	sun.visible = false

	var collision = sun.get_node_or_null("CollisionShape2D")
	if collision != null:
		collision.set_deferred("disabled", true)

	fire_timer.stop()
	fire_spawn_timer.stop()


func start_fire_phase():

	platformlari_yok_et()

	fire_timer.start()
	fire_spawn_timer.start()


func platformlari_yok_et():

	all_platforms.visible = false

	for node in all_platforms.get_children():

		node.visible = false

		if node is TileMap:
			for i in range(node.get_layers_count()):
				node.set_layer_enabled(i, false)

		for child in node.get_children():

			if child is CollisionShape2D:
				child.set_deferred("disabled", true)

			if child is StaticBody2D:
				for sub in child.get_children():
					if sub is CollisionShape2D:
						sub.set_deferred("disabled", true)


func _on_fire_spawn_timer_timeout():

	for i in range(3):

		var fire = fire_scene.instantiate()

		get_tree().current_scene.add_child(fire)

		fire.position = Vector2(
			randf_range(0, 1280),
			-50
		)


func _on_fire_timer_timeout():

	fire_spawn_timer.stop()

	await get_tree().create_timer(1.0).timeout

	sun.visible = true

	var collision = sun.get_node_or_null("CollisionShape2D")
	if collision != null:
		collision.set_deferred("disabled", false)
