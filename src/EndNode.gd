extends DialogNode

class_name EndNode


var repeat_button : CheckButton
var restart_button : CheckButton


func _ready():
	
	# Tipo
	type = "end"

	# Inicializar los controles
	repeat_button = get_node("Repeat/Repeat")
	restart_button = get_node("Restart/Restart")
	index_from = get_node("Connect/From")
	index_to = get_node("Connect/To")
	display_control = get_node("Display/LineEdit")
	line_control = get_node("Line/LineText")
	# Signal connecting

	restart_button.connect("button_up",self,"_on_restart_checked")
	repeat_button.connect("button_up",self,"_on_repeat_checked")


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


# Funcionalidad extra del nodo de tipo End

func is_repeat() -> bool:
	return repeat_button.toggle_mode

func is_restart() -> bool:
	return restart_button.toggle_mode


func _on_restart_checked() -> void:
	print(restart_button.toggle_mode)
	#if repeat_button.toggle_mode:
	#	restart_button.toggle_mode = false

func _on_repeat_checked() -> void:
	#if restart_button.toggle_mode:
	#	restart_button.toggle_mode = false
	pass
