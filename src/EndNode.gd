extends DialogNode

class_name EndNode

# Index of the node that leads to this node and
# it's attached to it
var to : Label
var from : Label

var repeat_button : CheckButton
var restart_button : CheckButton


func _ready():
	
	# Tipo
	type = "end"

	# Inicializar los controles
	repeat_button = get_node("Repeat/Repeat")
	restart_button = get_node("Restart/Restart")
	from = get_node("Connect/From")
	# Signal connecting

	restart_button.connect("pressed",self,"_on_restart_checked")
	repeat_button.connect("pressed",self,"_on_repeat_checked")

func set_index(index : int) -> void:
	# Si es el primer nodo, desconectar el slot izquierdo
	
	pass

func set_pointer(index : int) -> void:
	from.text = index as String

func get_index() -> int:
	return from.text as int

func is_repeat() -> bool:
	return repeat_button.toggle_mode

func is_restart() -> bool:
	return restart_button.toggle_mode


func _on_restart_checked() -> void:
	print(restart_button.toggle_mode)
	#if repeat_button.toggle_mode:
	#	restart_button.toggle_mode = false

func _on_repeat_checked() -> void:
	pass
	#if restart_button.toggle_mode:
	#	restart_button.toggle_mode = false
