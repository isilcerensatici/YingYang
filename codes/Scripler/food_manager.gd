extends Node2D

@onready var foods = $"../Foods".get_children()
@onready var sun = $"../sonrakiseviyesun"

var food_count := 0

func _ready():
	food_count = foods.size()

	# GÜVENLİK ÖNLEMİ: Eğer sahnede "sonrakiseviyesun" düğümü varsa işlemleri yap
	if sun:
		sun.visible = false
		# Çarpışma alanının adının tam olarak "CollisionShape2D" olduğundan emin oluyoruz
		var sun_collision = sun.get_node_or_null("CollisionShape2D")
		if sun_collision:
			sun_collision.set_deferred("disabled", true)

func food_collected():
	food_count -= 1
	print("Kalan yem:", food_count)

	if food_count <= 0:
		if sun:
			sun.visible = true
			var sun_collision = sun.get_node_or_null("CollisionShape2D")
			if sun_collision:
				sun_collision.set_deferred("disabled", false)

		print("Tüm yemler toplandı! Güneş açıldı, sonraki seviyeye geçilebilir.")
