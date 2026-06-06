extends CharacterBody2D

@export var speed: float = 120.0

# Editörden hangi karakteri kovalayacağını seçeceğiz
@export_enum("WhitePacman", "BlackPacman", "En Yakındakini Kovala") var target_mode: int = 0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var target_node: Node2D = null

func _ready():
	await get_tree().create_timer(0.2).timeout
	find_target()

func find_target():
	var current_scene = get_tree().current_scene
	
	# Nokta atışı: Üstteki boş düğümün altındaki asıl hareket eden gövdeye erişiyoruz
	if target_mode == 0:
		target_node = current_scene.get_node_or_null("WhitePacman/WhitePacman")
	elif target_mode == 1:
		target_node = current_scene.get_node_or_null("BlackPacman/BlackPacman")

func _physics_process(_delta):
	if target_mode == 2:
		target_node = get_closest_player()
		
	if not target_node or not is_instance_valid(target_node):
		find_target()
		return

	# Hayalete karakterin ANLIK pozisyonunu her karede güncelliyoruz
	nav_agent.target_position = target_node.global_position
	
	NavigationServer2D.map_force_update(nav_agent.get_navigation_map())

	if nav_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		return
		
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * speed
	
	velocity = new_velocity
	move_and_slide()
	
	check_player_collision()

func get_closest_player() -> Node2D:
	var current_scene = get_tree().current_scene
	# Yakınlık kontrolü için de içteki CharacterBody2D düğümlerine bakıyoruz
	var p1 = current_scene.get_node_or_null("WhitePacman/WhitePacman")
	var p2 = current_scene.get_node_or_null("BlackPacman/BlackPacman")
	
	if p1 and p2:
		var d1 = global_position.distance_to(p1.global_position)
		var d2 = global_position.distance_to(p2.global_position)
		return p1 if d1 < d2 else p2
	elif p1:
		return p1
	elif p2:
		return p2
	return null

func check_player_collision():
	# 1. GÜVENLİK BARİYERİ: Eğer hayalet sahne ağacında DEĞİLSE asla aşağıya geçme
	if not is_inside_tree():
		return
		
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider and (collider.name == "WhitePacman" or collider.name == "BlackPacman"):
			# 2. GÜVENLİK BARİYERİ: get_tree()'nin gerçekten var olduğunu double-check yapıyoruz
			var tree = get_tree()
			if tree and is_instance_valid(tree):
				print("Hayalet yakaladı: ", collider.name)
				tree.reload_current_scene()
				return
