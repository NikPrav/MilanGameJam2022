extends "res://Levels/Level1.gd"

func _ready():
	pass


func _on_LevelTrigger_area_entered(area):
	get_tree().change_scene("res://Levels/LabLevel.tscn")
