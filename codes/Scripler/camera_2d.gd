extends Camera2D

@export var speed: float = 55.0
@export var yin: NodePath
@export var yang: NodePath
@export var bottom_margin: float = 430.0
@export var start_delay: float = 5.0 # Müfettişten değiştirebileceğiniz gibi buradan da 2.0 yapabiliriz.

var aktif := false


func start_camera():
	enabled = true
	await get_tree().create_timer(start_delay).timeout
	aktif = true


func _process(delta):
	if not aktif:
		return

	global_position.y -= speed * delta
	# Karakterlerin ekran dışına çıkma kontrolünü sadece kamera hareket ederken yapıyoruz
	check_players()


func check_players():
	var yin_node = get_node_or_null(yin)
	var yang_node = get_node_or_null(yang)

	if yin_node == null or yang_node == null:
		return

	var limit_y = global_position.y + bottom_margin

	if yin_node.global_position.y > limit_y or yang_node.global_position.y > limit_y:
		get_tree().reload_current_scene()
