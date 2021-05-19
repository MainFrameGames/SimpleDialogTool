extends Control


class_name Editor


const INITIAL_POSITION : Vector2 = Vector2(40,40)

onready var checksum = HashingContext.new()
onready var exporter = Exporter.new()
onready var offset_index : int = 1
onready var index_stack : IndexStack = IndexStack.new()

var save_path : String
var current_hash : String
var graph_edit : GraphEdit
var scene_hash : String
var saved : bool
var file_dialog : FileDialog
var export_mode : int

var alert_dialog : AcceptDialog




func _ready():
	graph_edit = get_node("GraphEdit")
	#graph_edit.set_owner(self)
	alert_dialog = get_node("AlertDialog")
	file_dialog = get_node("FileDialog")
	saved = false
	
	Main.EVENTS.connect("add_menu_item_selected",self,"on_add_menu_item_selected")
	Main.EVENTS.connect("export_menu_item_selected",self,"on_export_menu_item_selected")
	Main.EVENTS.connect("exit_editor",self,"_on_exit_editor")
	
	Main.EVENTS.connect("save_project",self,"_on_save_project")

	# Señales de Graph Edit

	graph_edit.connect("connection_request",self,"_on_connection_request")
	file_dialog.connect("file_selected",self,"_on_save_exported_file")

	#save_file(Main.DEFAULT_SAVE_PATH)
	


func _on_disconnection_request(from, from_slot, to, to_slot):
	graph_edit.disconnect_node(from,from_slot,to,to_slot)

	
func _on_delete_request(node_to_delete : DialogNode) -> void:
	# Save the deleted index to indexes stack
	index_stack.remove_index(node_to_delete.get_index_from())


	var connection_list : Array = graph_edit.get_connection_list()

	for connection in connection_list:
	
		var node_to_disconnect = get_node("GraphEdit/" + connection['to'])
		# Delete indexes
		if node_to_disconnect.name == node_to_delete.name:
			node_to_disconnect.clear_index_to()
			print("clear index")
			# Disconnect slots
			node_to_disconnect.clear_slot(0)

	# Clear all connections from the node itself
	node_to_delete.clear_all_slots()
	# Delete node
	node_to_delete.queue_free()
	

func _on_connection_request(from, from_slot, to, to_slot) -> void:
	
	graph_edit.connect_node(from,from_slot,to,to_slot)

	# Actualizar el índice del nodo al que se conecta
	# Esta llamada es muy confusa, sustituir por algo más legible TODO
	var origin_node = get_node("GraphEdit/" + from)
	var arrival_node = get_node("GraphEdit/" + to)

	if origin_node is DecisionNode:
		origin_node.set_decision_index(from_slot,arrival_node.get_index_from())
	else:
		origin_node.set_index_to(arrival_node.get_index_from())

	


func _on_dialog_node_deleted(dialog_node_index : int) -> void:
	pass


func on_add_menu_item_selected(node_type) -> void:

	if !begin_node_exists() && node_type != Main.NODE_TYPES.BEGIN:
		show_alert("Operacion no permitida","Añade primero un nodo de tipo begin")
	elif begin_node_exists() && node_type == Main.NODE_TYPES.BEGIN:
		show_alert("Operacion no permitida","Ya existe un nodo de tipo begin")
	else:
		spawn_node(node_type)

func _on_save_exported_file(path : String) -> void:
	if export_mode == Main.EXPORT_TYPES.PROJECT:
		save_file(path)
	else:		
		exporter.export_dialog(get_tree().get_nodes_in_group("dialog_nodes"),path,export_mode)
		
func _on_save_project() -> void:
	export_mode = Main.EXPORT_TYPES.PROJECT
	file_dialog.popup_centered()


func on_export_menu_item_selected(menu_item : int) -> void:

	# Seleccionar el tipo de export según lo que se elija en el menú
	match menu_item:
		Main.EXPORT_TYPES.JSON: 
			export_mode = Main.EXPORT_TYPES.JSON
		Main.EXPORT_TYPES.GDSCRIPT:
			export_mode = Main.EXPORT_TYPES.GDSCRIPT
		Main.EXPORT_TYPES.SIGNALS:
			export_mode = Main.EXPORT_TYPES.SIGNALS

	# Llamar al explorador de archivos para guardar el archivo exportado
	file_dialog.popup_centered()


func spawn_node(node_type) -> void:
	
	# Retrieve node to spawn
	var node_to_spawn = Main.get_graph_node_instance(node_type)

	# Ajust node ofsset on the Graph Edit Board
	node_to_spawn.offset += INITIAL_POSITION
	node_to_spawn.offset *= offset_index
	offset_index += 1


	# Connect signal for deleting node
	node_to_spawn.connect("delete_node",self,"_on_delete_request")
	
	# Spawn node
	graph_edit.add_child(node_to_spawn)		
	# Set owner
	node_to_spawn.owner = self
	# Set node index from the stack only if is not a begin node

	if node_to_spawn.get_dialog_type() != "begin":
		node_to_spawn.set_index_from(index_stack.get_new_index())
	

func begin_node_exists() -> bool:
	var nodes = get_tree().get_nodes_in_group("dialog_nodes")

	for node in nodes:
		if node.get_dialog_type() == "begin":
			return true

	return false
		

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
	
	ResourceSaver.save(path + ".tscn",packed_scene)
	save_path = path	
	#generate_hash()

# UTILS

func show_alert(title : String, message : String) -> void:
	alert_dialog.window_title = title
	alert_dialog.dialog_text = message
	alert_dialog.popup_centered()

func get_uid() -> String:
	return Main.UID
