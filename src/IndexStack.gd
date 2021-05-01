extends Node

class_name IndexStack

# var added_indexes_stack : Array
var deleted_indexes_stack : Array

var auto_index : int = 1


func get_new_index() -> int:

	if deleted_indexes_stack.empty():

		var index = auto_index
		# added_indexes_stack.push_front(index)
		auto_index += 1
		return index

	else:
		return deleted_indexes_stack.pop_back()

func remove_index(index_to_remove : int) -> void:
	deleted_indexes_stack.push_front(index_to_remove)
	
