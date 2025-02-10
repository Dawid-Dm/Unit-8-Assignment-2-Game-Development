extends Node2D

func _ready() -> void:
	# Connect to the Player's coin_collected signal
	# (Adjust the path to your Player if necessary)
	var player = get_node("../Player")
	player.connect("coin_collected", self, "_on_player_coin_collected")

func _on_player_coin_collected(new_coin_count: int) -> void:
	# Update the label to display the new coin count
	$CoinLabel.text = "Coins: %d" % new_coin_count
