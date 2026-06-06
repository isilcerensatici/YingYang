extends Area2D

@onready var manager = get_tree().current_scene.get_node("FoodManager")

var collected := false

func _on_body_entered(body):

	if collected:
		return

	var name_lower = body.name.to_lower()

	if name_lower == "blackpacman" or name_lower == "whitepacman":

		collected = true

		manager.food_collected()

		queue_free()
