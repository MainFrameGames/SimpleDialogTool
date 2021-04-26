extends Control


class_name Editor



const INITIAL_POSITION : Vector2 = Vector2(40,40)

onready var checksum = HashingContext.new()
onready var exporter = Exporter.new()
onready var instance_index : int = 0


var save_path : String
var current_hash : String
var graph_nodes : Array
var graph_edit : GraphEdit
var scene_hash : String
var saved : bool





func _ready():
	graph_edit = get_node("GraphEdit")
	saved = false
	
	Main.EVENTS.connect("add_menu_item_selected",self,"on_add_menu_item_selected")
	Main.EVENTS.connect("export_menu_item_selected",self,"on_export_menu_item_selected")
	Main.EVENTS.connect("exit_editor",self,"_on_exit_editor")
	
	# Señales de Graph Edit

	graph_edit.connect("connection_request",self,"_on_connection_request")
	#graph_edit.connect("disconnection_request",self,"_on_disconnection_request")

	save_file(Main.DEFAULT_SAVE_PATH)
	




func _on_connection_request(from, from_slot, to, to_slot) -> void:
	
	graph_edit.connect_node(from,from_slot,to,to_slot)

	print(graph_edit.get_connection_list())



func on_add_menu_item_selected(node_type) -> void:
	spawn_node(node_type)

func on_export_menu_item_selected(menu_item : int) -> void:
	
	match menu_item:
		Main.EXPORT_TYPES.JSON:
			print("json")
			exporter.export_to_json(get_tree().get_nodes_in_group("dialog_nodes"),"res://exported/","test_name")
		_:
			pass
	


func spawn_node(node_type) -> void:
	
	
	var node_to_spawn
	
	node_to_spawn = Main.get_graph_node_instance(node_type)

	
	node_to_spawn.offset += INITIAL_POSITION

	if instance_index > 0:
		node_to_spawn.offset *= instance_index

	node_to_spawn.set_index(instance_index)

	graph_nodes.append(node_to_spawn)
	graph_edit.add_child(node_to_spawn)		

	instance_index += 1
	


func _on_exit_editor() -> void:
	Main.exit()

func generate_hash() -> void:
	pass
	#checksum.start(HashingContext.HASH_SHA1)
	#var f = File.new()
	#f.open(save_path, File.READ)

	#while not f.eof_reached():

	#	checksum.update(f.get_buffer(1024))
	#	print("works")
	
	#current_hash = checksum.finish() as String
	#print(current_hash)
	
	

func save_file(path) -> void:
	
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	
	ResourceSaver.save(path 
	+ "editor_file_" 
	+ String(OS.get_system_time_secs()) 
	+ ".tscn",packed_scene)
	save_path = path	
	#generate_hash()
		

		


func get_uid() -> String:
	return Main.UID



func _on_disconnection_request(from, from_slot, to, to_slot):
	graph_edit.disconnect_node(from,from_slot,to,to_slot)
