extends DialogNode


func _ready():
	type = "begin"
	index_from = get_node("Connect/From")
	index_to = get_node("Connect/To")
	display_control = get_node("Display/LineEdit")
	line_control = get_node("Line/LineText")

	assert (index_from != null)


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
