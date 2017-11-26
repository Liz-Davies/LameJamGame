extends TileMap

# class member variables go here, for example:
var x = 0
var y = 0

func _ready():
	for i in range(10):
		for j in range(10):
			var temp=get_node("human").duplicate()
			temp.set_pos(Vector2(800+(i*200),100-(j*100)))
			add_child(temp)
	
	get_child(0).duplicate(true)
	get_child(0).duplicate(true)
	
	pass
