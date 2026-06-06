extends Node2D

@export var yin_final: NodePath
@export var yang_final: NodePath

@export var black_platforms: NodePath
@export var white_platforms: NodePath

@export var black_lamp: NodePath
@export var blue_lamp: NodePath

@export var keys: NodePath
@export var final_buttons: NodePath
@export var background_color: NodePath
@export var parallax_background: NodePath

@export var final_platform_spawn_timer: NodePath
@export var final_platform_spawner: NodePath
@export var final_camera: NodePath

var collected_keys := 0
var total_keys := 4

var white_final_pressed := false
var black_final_pressed := false
var final_started := false


func _ready():
	set_character_active(yin_final, true)
	set_character_active(yang_final, false)

	set_group_active(black_platforms, true)
	set_group_active(white_platforms, false)

	set_node_active(black_lamp, true)
	set_node_active(blue_lamp, false)

	set_group_active(keys, false)
	set_group_active(final_buttons, false)

	set_background(Color.WHITE)

	var parallax = get_node_or_null(parallax_background)
	if parallax != null:
		parallax.visible = false

	var timer = get_node_or_null(final_platform_spawn_timer)
	if timer != null:
		timer.stop()

	var cam = get_node_or_null(final_camera)
	if cam != null:
		cam.enabled = false


func start_black_phase():
	set_character_active(yin_final, false)
	set_character_active(yang_final, true)

	set_group_active(black_platforms, false)
	set_group_active(white_platforms, true)

	set_node_active(black_lamp, false)
	set_node_active(blue_lamp, true)

	set_background(Color.BLACK)


func start_blue_phase():
	set_character_active(yin_final, true)
	set_character_active(yang_final, true)

	set_group_active(black_platforms, true)
	set_group_active(white_platforms, true)

	set_node_active(blue_lamp, false)
	set_group_active(keys, true)

	var bg = get_node_or_null(background_color)
	if bg != null:
		bg.visible = false

	var parallax = get_node_or_null(parallax_background)
	if parallax != null:
		parallax.visible = true


func key_collected():
	collected_keys += 1
	print("Toplanan anahtar:", collected_keys)

	if collected_keys >= total_keys:
		final_butonlari_ac()


func final_butonlari_ac():
	set_group_active(final_buttons, true)
	print("Final butonları açıldı")


func white_final_button_pressed():
	white_final_pressed = true
	print("WhiteFinalButton aktif")
	check_final_buttons()


func black_final_button_pressed():
	black_final_pressed = true
	print("BlackFinalButton aktif")
	check_final_buttons()


func check_final_buttons():
	if white_final_pressed and black_final_pressed:
		# ÇÖZÜM BURADA: Fizik motorunu kilitlememek için final fazını güvenli kareye erteliyoruz
		call_deferred("start_final_phase")


# Fonksiyon tanımı orijinal standardına döndürüldü
func start_final_phase():
	if final_started:
		return

	final_started = true
	print("Final fazı başladı")

	var buttons = get_node_or_null(final_buttons)
	if buttons != null:
		buttons.call_deferred("queue_free")

	set_group_active(keys, false)
	set_group_active(black_platforms, false)
	set_group_active(white_platforms, false)

	var bg = get_node_or_null(background_color)
	if bg != null:
		bg.visible = false

	var parallax = get_node_or_null(parallax_background)
	if parallax != null:
		parallax.visible = true

	var spawner = get_node_or_null(final_platform_spawner)
	if spawner != null:
		spawner.spawn_start_platforms()

	# NOT: Zamanlayıcı start_start_platforms() içinde zaten tetikleniyor,
	# ama garanti olsun diye burada da kalabilir.
	var timer = get_node_or_null(final_platform_spawn_timer)
	if timer != null:
		timer.start()

	var cam = get_node_or_null(final_camera)
	if cam != null:
		cam.start_camera()


func set_character_active(character_path: NodePath, active: bool):
	var c = get_node_or_null(character_path)
	if c == null:
		return

	c.set_active(active)


func set_node_active(node_path: NodePath, active: bool):
	var node = get_node_or_null(node_path)
	if node == null:
		return

	node.visible = active

	for child in node.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", not active)


func set_group_active(group_path: NodePath, active: bool):
	var group = get_node_or_null(group_path)
	if group == null:
		return

	group.visible = active

	if group is TileMap:
		for i in range(group.get_layers_count()):
			group.set_layer_enabled(i, active)

	for node in group.get_children():
		node.visible = active

		if node is TileMap:
			for i in range(node.get_layers_count()):
				node.set_layer_enabled(i, active)

		for child in node.get_children():
			if child is CollisionShape2D:
				child.set_deferred("disabled", not active)


func set_background(color: Color):
	var bg = get_node_or_null(background_color)

	if bg == null:
		print("HATA: BackGroundColor bulunamadı")
		return

	bg.visible = true
	bg.color = color
