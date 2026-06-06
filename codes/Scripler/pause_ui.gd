extends CanvasLayer

@onready var pause_panel = $PausePanel

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_panel.visible = false

func _input(event):
	if event.is_action_pressed("pause_game"):
		if get_tree().paused:
			get_tree().paused = false
			pause_panel.visible = false
		else:
			get_tree().paused = true
			pause_panel.visible = true
