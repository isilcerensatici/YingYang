extends CharacterBody2D

const SPEED = 250.0

@onready var sprite = $Sprite2D

func _physics_process(_delta):

	var direction = Vector2.ZERO

	if Input.is_action_pressed("blackpacmansola"):
		direction.x -= 1
		sprite.rotation_degrees = 180

	if Input.is_action_pressed("blackpacmansaga"):
		direction.x += 1
		sprite.rotation_degrees = 0

	if Input.is_action_pressed("blackpacmanyukari"):
		direction.y -= 1
		sprite.rotation_degrees = -90

	if Input.is_action_pressed("blackpacmanasagi"):
		direction.y += 1
		sprite.rotation_degrees = 90

	velocity = direction.normalized() * SPEED

	move_and_slide()
