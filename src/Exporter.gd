extends Node

class_name Exporter


func export_project_callbacks(dialog_nodes : Array) -> String:
	var exported_callbacks : String = "extends Node\n\n"
	
	for i in dialog_nodes:
		var callbacks : Array = i.get_callbacks()
		for y in callbacks:
			exported_callbacks += callbacks[y] + "\n"
	
	return exported_callbacks


# JSON
func export_to_json(nodes_to_export : Array, path : String, name : String) -> void:
	
	var export_dic : Dictionary
	
	assert( nodes_to_export != null)

	for i in nodes_to_export:
		
		if i.get_dialog_type() == "normal":
			export_dic[i.get_dialog_index()] = _parse_simple_node(i)
		elif i.get_dialog_type() == "decision":
			pass
		elif i.get_dialog_type() == "end":
			export_dic[i.get_dialog_index()] = _parse_end_node(i)
		

	print(export_dic)




func _parse_simple_node(node : DialogNode) -> Dictionary:
	
	var node_tree_dic : Dictionary
		
	node_tree_dic['type'] = node.get_dialog_type()
	node_tree_dic['display'] = node.get_display()
	node_tree_dic['line'] = node.get_line()
	node_tree_dic['callbacks'] = node.get_callbacks()
	node_tree_dic['pointer'] = node.get_pointer()

	return node_tree_dic

func _parse_end_node(node : EndNode) -> Dictionary:
	
	var node_tree_dic : Dictionary = _parse_simple_node(node)
	
	node_tree_dic['repeat'] = node.is_repeat()
	node_tree_dic['restart'] = node.is_restart()


	return node_tree_dic

func _parse_decision_node(node : DialogNode) -> Dictionary:
	return {}
