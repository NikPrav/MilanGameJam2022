extends "res://Levels/Level1.gd"


func _ready():
	pass


func _on_LevelTrigger_body_entered(body):

	if(body.is_in_group("player")):
		get_tree().change_scene("res://UI/Ending.tscn")


