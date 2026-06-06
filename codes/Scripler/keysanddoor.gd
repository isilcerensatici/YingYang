extends Node2D

@onready var door = $bolum2door

var collected_keys := 0
var total_keys := 4

func key_collected():

	collected_keys += 1

	print(collected_keys)

	if collected_keys >= total_keys:
		door.open()
