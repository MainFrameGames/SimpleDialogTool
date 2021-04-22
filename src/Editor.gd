extends Control


class_name Editor



const INITIAL_POSITION : Vector2 = Vector2(40,40)

var instance_index : int = 0
var graph_nodes : Array
var graph_edit : GraphEdit

var saved : bool





func _ready():
	graph_edit = get_node("GraphEdit")
	saved = false
	
	Main.EVENTS.connect("add_menu_item_selected",self,"on_add_menu_item_selected")
	Main.EVENTS.connect("export_menu_item_selected",self,"on_export_menu_item_selected")
	Main.EVENTS.connect("exit_editor",self,"_on_exit_editor")

func on_add_menu_item_selected(node_type) -> void:
	print(node_type)
	spawn_node(node_type)

func on_export_menu_item_selected(menu_item : int) -> void:
	
	match menu_item:
		Main.EXPORT_TYPES.JSON:
			print("json")
		_:
			pass
	


func spawn_node(node_type) -> void:
	
	instance_index += 1
	var node_to_spawn
	
	node_to_spawn = Main.get_graph_node_instance(node_type)
	node_to_spawn.offset += INITIAL_POSITION * instance_index
	graph_nodes.append(node_to_spawn)
	graph_edit.add_child(node_to_spawn)		
	


func _on_exit_editor() -> void:
	Main.exit()


func get_uid() -> String:
	return Main.UID
