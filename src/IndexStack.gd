extends Node

# Controls and genereates the indexes for Dialog Nodes
# in a stack format, when a node spanwns, the class pops a new index
# When a node is deleted, the index is pushed to a stack and it will be the next
# index the class will dispatch to the new spawned node.

class_name IndexStack


var deleted_indexes_stack : Array
var auto_index : int = 1


# Get new index for the DialogNode which has spawned
func get_new_index() -> int:

	if deleted_indexes_stack.empty():

		var index = auto_index
		auto_index += 1
		return index

	else:
		return deleted_indexes_stack.pop_back()


# Get back the index of a deleted node
func remove_index(index_to_remove : int) -> void:
	deleted_indexes_stack.push_front(index_to_remove)
	
