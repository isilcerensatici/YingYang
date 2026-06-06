extends Area2D

@export var speed: float = 250.0

func _process(delta):
	position.y += speed * delta


func _on_body_entered(body):
	if body.name.to_lower() == "yin" or body.name.to_lower() == "yang":
		get_tree().call_deferred("reload_current_scene")


func _on_visible_on_screen_notifier_2d_screen_exited():
	call_deferred("queue_free")
