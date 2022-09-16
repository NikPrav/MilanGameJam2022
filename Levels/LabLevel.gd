extends Node2D

var cur_layer

func _physics_process(delta):
	cur_layer = get_node("Player").cur_layer


#func _on_LevelTrigger_area_entered(area):
#	get_tree().change_scene("res://Levels/BunkerLevel.tscn")


func _on_LevelTrigger_body_entered(body):
	if(body.is_in_group("player")):
		get_tree().change_scene("res://Levels/BunkerLevel.tscn")
