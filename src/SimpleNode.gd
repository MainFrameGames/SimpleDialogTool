extends "res://src/DialogNode.gd"


class_name SimpleNode


func _ready():
	
	type = "normal"
	index_from = get_node("Connect/From")
	index_to = get_node("Connect/To")
	display_control = get_node("Display/LineEdit")
	line_control = get_node("Line/LineText")

	
func set_index_from(index : int) -> void:
	
	index_from.text = index as String
	
func set_index_to(index : int) -> void:
	
	index_to.text = index as String


func get_index_from() -> int:
		
	return index_from.text as int
		
	
func get_index_to() -> int:
		
	return index_to.text as int
	
	
func get_callbacks() -> Array:
		
	return get_node("Callbacks").get_callbacks() 
