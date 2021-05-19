extends Node

class_name Exporter



func export_project_callbacks(dialog_nodes : Array) -> String:
	var exported_callbacks : String = "extends Node\n\n"
	
	for i in dialog_nodes:
		var callbacks : Array = i.get_callbacks()
		for y in callbacks:
			exported_callbacks += "signal " + y + "\n"
	
	return exported_callbacks



func export_dialog(nodes_to_export : Array, path : String, export_type : int) -> void:

	assert( nodes_to_export != null)
	#var export_dic : Dictionary = parse_dialog(nodes_to_export)

	var f = File.new()
	f.open(path, File.WRITE)
	
	match export_type:
		Main.EXPORT_TYPES.JSON:
			path += ".json"
			f.store_line(to_json(parse_dialog(nodes_to_export)))
		Main.EXPORT_TYPES.GDSCRIPT:
			path += ".gd"
			f.store_var(parse_dialog(nodes_to_export))
		Main.EXPORT_TYPES.SIGNALS:
			path += ".gd"
			print(path)
			f.store_string(export_project_callbacks(nodes_to_export))
		_:
			print("Debug --> funcion export desconocida")
	f.close()


func parse_dialog(nodes_to_export : Array) -> Dictionary:
	var export_dic : Dictionary

	for i in nodes_to_export:
		
		if i.get_dialog_type() == "normal" || i.get_dialog_type() == "begin":
			export_dic[i.get_index_from()] = _parse_simple_node(i)
		elif i.get_dialog_type() == "decision":
			export_dic[i.get_index_from()] = _parse_decision_node(i)
		elif i.get_dialog_type() == "end":
			export_dic[i.get_index_from()] = _parse_end_node(i)
		
	print(export_dic)

	return export_dic

func _parse_simple_node(node : DialogNode) -> Dictionary:
	
	var node_tree_dic : Dictionary
		
	node_tree_dic['type'] = node.get_dialog_type()
	node_tree_dic['display'] = node.get_display()
	node_tree_dic['line'] = node.get_line()

	if node.get_dialog_type() != "decision":
		node_tree_dic['callbacks'] = node.get_callbacks()
		node_tree_dic['pointer'] = node.get_index_to()

	return node_tree_dic

func _parse_end_node(node : EndNode) -> Dictionary:
	
	var node_tree_dic : Dictionary = _parse_simple_node(node)
	
	node_tree_dic['repeat'] = node.is_repeat()
	node_tree_dic['restart'] = node.is_restart()


	return node_tree_dic

func _parse_decision_node(node : DialogNode) -> Dictionary:
	
	# Parse la parte que comparten todos los nodos
	var node_tree_dic : Dictionary = _parse_simple_node(node)
	# El nodo de tipo dialogo ya se encarga de pasar las decisiones ya formateadas
	node_tree_dic['decisiones'] = node.get_decisions()
	
	return node_tree_dic
