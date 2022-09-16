extends Node2D

var coins = 0
var lives = 3

func _ready():
	$CoinCount.text = str(coins)
	$LivesCount.text = str(lives)


func _on_coin_collected():
	coins += 1
	_ready()
