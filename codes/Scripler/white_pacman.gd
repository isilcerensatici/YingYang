extends CharacterBody2D

const SPEED = 250.0

@onready var sprite = $Sprite2D

func _physics_process(_delta):

	var direction = Vector2.ZERO

	if Input.is_action_pressed("whitepacmansola"):
		direction.x -= 1
		sprite.rotation_degrees = 180

	if Input.is_action_pressed("whitepacmansaga"):
		direction.x += 1
		sprite.rotation_degrees = 0

	if Input.is_action_pressed("whitepacmanyukari"):
		direction.y -= 1
		sprite.rotation_degrees = -90

	if Input.is_action_pressed("whitepacmanasagi"):
		direction.y += 1
		sprite.rotation_degrees = 90

	velocity = direction.normalized() * SPEED

	move_and_slide()
