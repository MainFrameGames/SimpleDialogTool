extends Control


var add_node_group : MenuButton

func _ready():
	add_node_group = get_node("HBoxContainer/AñadirNodo")

	add_node_group.get_popup().connect("id_pressed",self,"on_add_node_menu_pressed")



func on_add_node_menu_pressed(index : int) -> void:

	var node_type 

	match index:
		Main.NODE_TYPES.NORMAL:
			node_type = Main.NODE_TYPES.NORMAL
		Main.NODE_TYPES.CHOICE:
			pass
		Main.NODE_TYPES.END:
			pass
		_:
			node_type = null

		
	Main.EVENTS.emit_signal("add_menu_item_selected",node_type)
