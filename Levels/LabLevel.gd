extends Node2D

var cur_layer

func _physics_process(delta):
	cur_layer = get_node("Player").cur_layer


func _on_LevelTrigger_area_entered(area):
	get_tree().change_scene("res://Levels/BunkerLevel.tscn")
