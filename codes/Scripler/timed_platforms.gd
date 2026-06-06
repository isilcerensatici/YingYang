extends Node2D

@export var aktif_kalma_suresi: float = 2.0
@export var bekleme_suresi: float = 0.5

var sol_platformlar = []
var sag_platformlar = []

func _ready():
	for i in range(6, 0, -1):
		var p = get_node("timerplatform" + str(i))
		sol_platformlar.append(p)
		platform_kapat(p)

	for i in range(12, 6, -1):
		var p = get_node("timerplatform" + str(i))
		sag_platformlar.append(p)
		platform_kapat(p)

	sol_dongu()
	sag_dongu()


func sol_dongu():
	while true:
		for p in sol_platformlar:
			platform_ac(p)
			await get_tree().create_timer(aktif_kalma_suresi).timeout
			platform_kapat(p)
			await get_tree().create_timer(bekleme_suresi).timeout


func sag_dongu():
	while true:
		for p in sag_platformlar:
			platform_ac(p)
			await get_tree().create_timer(aktif_kalma_suresi).timeout
			platform_kapat(p)
			await get_tree().create_timer(bekleme_suresi).timeout


func platform_ac(p):
	p.visible = true
	p.get_node("CollisionShape2D").set_deferred("disabled", false)


func platform_kapat(p):
	p.visible = false
	p.get_node("CollisionShape2D").set_deferred("disabled", true)
