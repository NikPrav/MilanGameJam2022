extends Node2D

var coins = 0
var lives = 3

func _ready():
	$CoinsPanel/CoinCount.text = String(coins)
	$LivesPanel/LivesCount.text = String(lives)


func _on_coin_collected():
	coins += 1
	_ready()

func _on_lives_lost():
	lives -= 1
	_ready()
