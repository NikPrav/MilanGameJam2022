extends Area2D


func _ready():
	pass


func _on_LevelTrigger_body_entered(body):
	get_tree().change_scene("res://Levels/LabLevel.tscn")

