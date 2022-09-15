extends Area2D

signal coin_collected


func _ready():
	pass # Replace with function body.


func _on_Coin_body_entered(body):
	print("Coin Collected")
	emit_signal("coin_collected")
	
	
	
	$AnimationPlayer.play("Bounce")
	

#	body.add_coin()
#	queue_free()
	


func _on_AnimationPlayer_animation_finished(anim_name):
	print("Coin Deleted")
	
	queue_free()

	


	
