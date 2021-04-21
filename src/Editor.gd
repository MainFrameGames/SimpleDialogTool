extends Control



class_name Editor

var graph_nodes : Array
var graph_edit



func _ready():
	Main.EVENTS.connect("add_menu_item_selected",self,"on_add_menu_item_selected")
	graph_edit = get_node("GraphEdit")

func on_add_menu_item_selected(node_type) -> void:
	spawn_node(node_type)


func spawn_node(node_type) -> void:
	
	var node_to_spawn

	match node_type:
		Main.NODE_TYPES.NORMAL:
			print("NODO NORMAL")
			node_to_spawn = Main.get_normal_node_instance()
			graph_nodes.append(node_to_spawn)
			graph_edit.add_child(node_to_spawn)		
		_:
			print("default")
