extends Control


onready var graph = load("res://Graph.tscn")
const INITIAL_POSITION : Vector2 = Vector2(40,40)
var instance_index : int = 0

func on_add():
	var instance = graph.instance()
	instance_index += 1
	instance.offset += INITIAL_POSITION * instance_index
	$GraphEdit.add_child(instance)


func _on_connection_request(from, from_slot, to, to_slot):
	$GraphEdit.connect_node(from,from_slot,to,to_slot)
