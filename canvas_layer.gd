extends Node

@onready var coin_label = $CoinLabel
var coin_count = 0

func _ready():
	if coin_label == null:
		print("Label node not found!")
	
	var character = get_node("../Player") 
	if character:
		print("Character node found:", character)
		character.connect("coin_collected", Callable(self, "_on_coin_collected"))
	else:
		print("Character node not found!")

func _on_coin_collected(new_coin_count):
	coin_count = new_coin_count 
	if coin_label != null:
		coin_label.text = "Coin collected! Total coins: %d" % coin_count
