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
		#export_dic[nodes_to_export[i].get_dialog_index()] = nodes_to_export[i].get_dialog_type()
		#export_dic[i.get_dialog_index()] = i.get_dialog_type()
		print(i.name)

	#print(export_dic)


