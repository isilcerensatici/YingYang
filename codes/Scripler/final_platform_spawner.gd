extends Node2D

@export var final_platform_scene: PackedScene
@export var camera: NodePath

@export var min_x: float = 120.0
@export var max_x: float = 1150.0

@export var vertical_gap: float = 75.0      # Karakter zıplama sınırı (max 82)
@export var horizontal_gap_min: float = 100.0
@export var horizontal_gap_max: float = 200.0

# ÜST ÜSTE BİNMEYİ ENGELLEYEN DEĞİŞKEN:
# Platformunuzun piksel genişliğine göre bunu ayarlayabilirsiniz. 
# Örneğin platformunuz 100 piksel genişliğindeyse, yeni platform eskisine yatayda en az 90 piksel uzak olmalı.
@export var platform_width_margin: float = 90.0

var last_spawn_y: float = 0.0
var last_spawn_x: float = 640.0
var is_spawning_started := false

func spawn_start_platforms():
	var cam = get_node_or_null(camera) as Camera2D
	if cam == null:
		return
		
	is_spawning_started = true
	
	# 1. Başlangıçta ekranın en altında kalıcı ilk zemin
	last_spawn_y = cam.global_position.y + 300
	last_spawn_x = 640.0
	
	var start_platform = final_platform_scene.instantiate()
	get_tree().current_scene.add_child(start_platform)
	start_platform.global_position = Vector2(last_spawn_x, last_spawn_y)
	
	# 2. Ekranın içini dolduracak kadar ilk platformları diz
	for i in range(5):
		spawn_single_platform()

func _process(_delta: float) -> void:
	if not is_spawning_started:
		return
		
	var cam = get_node_or_null(camera) as Camera2D
	if cam == null:
		return
		
	# Kameranın üst sınırı (ekranın tavanı)
	var camera_top_boundary = cam.global_position.y - 352
	
	# En son üretilen platform ekrandan içeri girmek üzereyse tam gözünün önünde yenisini doğur
	if last_spawn_y > camera_top_boundary:
		spawn_single_platform()
		
	# Kameranın alt sınırından aşağıda kalan eski platformları temizle
	var camera_bottom_boundary = cam.global_position.y + 352
	for child in get_tree().get_nodes_in_group("final_platforms_group"):
		if child.global_position.y > camera_bottom_boundary + 100:
			child.queue_free()

func spawn_single_platform():
	# 1. Önce rastgele bir yön seç (-1 sol, 1 sağ)
	var direction = [-1, 1].pick_random()
	
	# 2. Rastgele bir mesafe hesapla
	var chosen_offset = randf_range(horizontal_gap_min, horizontal_gap_max)
	
	# MANTIK KONTROLÜ: Eğer seçilen mesafe platform genişlik sınırından (platform_width_margin) küçükse,
	# platformların dikeyde üst üste binme ihtimali doğar. 
	# Bu durumda üst üste binmesinler diye mesafeyi güvenli sınıra (platform_width_margin) eşitliyoruz.
	if chosen_offset < platform_width_margin:
		chosen_offset = platform_width_margin
		
	# Yeni X pozisyonunu belirle
	var next_x = last_spawn_x + (direction * chosen_offset)
	
	# 3. Ekran kenarları kontrolü ve sıkışma engelleme
	if next_x < min_x:
		# Sol duvara çarptıysa zorla sağa fırlat
		next_x = last_spawn_x + randf_range(platform_width_margin, horizontal_gap_max)
	elif next_x > max_x:
		# Sağ duvara çarptıysa zorla sola fırlat
		next_x = last_spawn_x - randf_range(platform_width_margin, horizontal_gap_max)
		
	# Son kontrollerle sınırları koru
	last_spawn_x = clamp(next_x, min_x, max_x)
	
	# Dikeyde yukarı kaydır
	last_spawn_y -= vertical_gap

	var platform = final_platform_scene.instantiate()
	platform.add_to_group("final_platforms_group")
	
	get_tree().current_scene.add_child(platform)
	platform.global_position = Vector2(last_spawn_x, last_spawn_y)
