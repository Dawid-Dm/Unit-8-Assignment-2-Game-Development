extends Node

@onready var cLabel = $CanvasLayer/Label  # Correct path
var coin_count = 0

func _ready():
	if cLabel == null:
		print("Label node not found!")
	else:
		print("Label node found!")
		cLabel.text = "Coin collected! Total coins: 0"

func _on_coin_collected():
	coin_count += 1
	if cLabel != null:
		cLabel.text = "Coin collected! Total coins: %d" % coin_count
