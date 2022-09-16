extends Area2D


func _on_LevelTrigger_body_entered(body):
	if(body.is_in_group("player")):
		get_tree().change_scene("res://Levels/BunkerLevel.tscn")
