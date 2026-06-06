extends Node2D

@onready var yin_lock_box = $"../YinLockBox"
@onready var yang_lock_box = $"../YangLockBox"

@onready var white_button = $"../bolum6whitebutton"
@onready var black_button = $"../bolum6blackbutton"

@onready var sun = $"../sonrakiseviyesun"

@onready var whitekey1 = $"../bolum6keys/bolum6whitekey1"
@onready var whitekey2 = $"../bolum6keys/bolum6whitekey2"

@onready var blackkey1 = $"../bolum6keys/bolum6blackkeys1"
@onready var blackkey2 = $"../bolum6keys/bolum6blackkeys2"

var white_keys_collected := 0
var black_keys_collected := 0


func _ready():

	# Başlangıçta beyaz karakter (Yang) kilitli
	yang_lock_box.visible = true
	yang_lock_box.process_mode = Node.PROCESS_MODE_INHERIT

	# Siyah karakter (Yin) serbest
	yin_lock_box.visible = false
	yin_lock_box.process_mode = Node.PROCESS_MODE_DISABLED

	# Butonlar başlangıçta gizli
	white_button.visible = false
	white_button.process_mode = Node.PROCESS_MODE_DISABLED

	black_button.visible = false
	black_button.process_mode = Node.PROCESS_MODE_DISABLED

	# Güneş başlangıçta gizli
	sun.visible = false
	sun.process_mode = Node.PROCESS_MODE_DISABLED

	# Beyaz anahtarlar başlangıçta görünür
	whitekey1.visible = true
	whitekey2.visible = true
	whitekey1.process_mode = Node.PROCESS_MODE_INHERIT
	whitekey2.process_mode = Node.PROCESS_MODE_INHERIT

	# Siyah anahtarlar başlangıçta gizli
	blackkey1.visible = false
	blackkey2.visible = false
	blackkey1.process_mode = Node.PROCESS_MODE_DISABLED
	blackkey2.process_mode = Node.PROCESS_MODE_DISABLED


func white_key_collected(key):
	key.queue_free()

	white_keys_collected += 1
	print("Beyaz anahtar toplandı:", white_keys_collected)

	if white_keys_collected >= 2:
		white_button.visible = true
		white_button.process_mode = Node.PROCESS_MODE_INHERIT


func white_button_pressed():

	# Beyaz karakterin kafesi açılır
	yang_lock_box.set_deferred("visible", false)
	yang_lock_box.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)

	# Siyah karakter kafese alınır
	yin_lock_box.set_deferred("visible", true)
	yin_lock_box.set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)

	# Beyaz buton kapanır
	white_button.set_deferred("visible", false)
	white_button.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)

	# Siyah anahtarlar ortaya çıkar
	blackkey1.set_deferred("visible", true)
	blackkey2.set_deferred("visible", true)
	blackkey1.set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
	blackkey2.set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)


func black_key_collected(key):
	key.queue_free()

	black_keys_collected += 1
	print("Siyah anahtar toplandı:", black_keys_collected)

	if black_keys_collected >= 2:
		black_button.visible = true
		black_button.process_mode = Node.PROCESS_MODE_INHERIT
		
func black_button_pressed():

	# Siyah karakterin kafesi açılır
	yin_lock_box.set_deferred("visible", false)
	yin_lock_box.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)

	# Siyah buton kaybolur
	black_button.set_deferred("visible", false)
	black_button.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)

	# Güneş ortaya çıkar
	sun.set_deferred("visible", true)
	sun.set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
