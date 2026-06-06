extends CanvasLayer

@export var bolum_adi: String = "Bölüm Bilgisi"
@export_multiline var bolum_aciklamasi: String = "Bu bölümde ne yapılacağını okuyun."

@onready var guide_panel = $GuidePanel
@onready var title_label = $GuidePanel/TitleLabel
@onready var guide_text = $GuidePanel/GuideText

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	title_label.text = bolum_adi
	guide_text.text = bolum_aciklamasi
	
	get_tree().paused = true
	guide_panel.visible = true

func _on_start_button_pressed():
	guide_panel.visible = false
	get_tree().paused = false
