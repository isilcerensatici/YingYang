extends Area2D

@onready var manager = get_tree().current_scene.get_node("Bolum3Manager")

var collected := false

func _ready():
	visible = false
	$CollisionShape2D.disabled = true

func _on_body_entered(body):
	if collected:
		return

	if body.name.to_lower() == "yin" or body.name.to_lower() == "yang":
		collected = true
		manager.key_collected()
		queue_free()
