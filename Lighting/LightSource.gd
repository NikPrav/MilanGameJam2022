extends Sprite

export var layer = 0
export var nrg = 1.23
export var color = Color(1,1,1,1)

func _ready():
	$Light2D.color = color

func _physics_process(delta):
	var node = get_parent().get_parent()
	if int(node.cur_layer) != layer:
		$Light2D.energy = 0
	else:
		$Light2D.energy = nrg
	
	
