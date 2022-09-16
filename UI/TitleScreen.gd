extends Node2D

func _physics_process(delta):
	if(Input.is_action_just_pressed("continue")):
		get_tree().change_scene("res://UI/StoryScene.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://UI/StoryScene.tscn")
