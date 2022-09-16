extends Node2D

func _ready():
	$Timer.start()
	
func _physics_process(delta):
	if(Input.is_action_just_pressed("continue")):
		get_tree().change_scene("res://Levels/DesertLevel.tscn")

func _on_Timer_timeout():
	get_tree().change_scene("res://Levels/DesertLevel.tscn")
