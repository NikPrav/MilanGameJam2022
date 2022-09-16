extends CanvasLayer

var coins = 0

func _ready():
	$CoinCount.text = str(coins)

func _physics_process(delta):
		# Checking if enough coins have been collected
	if coins == 3:
		get_tree().change_scene("res://Levels/Level1.tscn")

func _on_coin_collected():
	coins += 1
	_ready()
