extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var aktif := true

func set_active(value: bool):
	aktif = value
	visible = value

	if not aktif:
		velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not aktif:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("yukari") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("sola", "saga")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
