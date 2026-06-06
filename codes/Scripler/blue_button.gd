extends Area2D

@onready var manager = get_tree().current_scene.get_node("Bolum3Manager")

func _ready():
	visible = false
	$CollisionShape2D.disabled = true

func _on_body_entered(body):
	if body.name.to_lower() == "yang":
		manager.make_blue()
		queue_free()
