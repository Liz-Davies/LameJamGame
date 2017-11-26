
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	for menu in get_node("menus").get_children():
		menu.connect("option_selected", self, "selected")
	pass

func selected(o):
	print("Option selected: ",o)
	if(o == "PlayAgain"):
		get_tree().change_scene("dungeon.tscn")
	elif(o =="Play"):
		get_tree().change_scene("dungeon.tscn")
	elif(o == "Quit"):
		get_tree().quit()

func select_menu(n):
	for menu in range(0, get_node("menus").get_child_count()):
		get_node("menus").get_child(menu).set_menu(false)
		if menu == n:
			get_node("menus").get_child(menu).set_menu(true)
