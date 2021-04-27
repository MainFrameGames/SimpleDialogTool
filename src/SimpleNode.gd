extends "res://src/DialogNode.gd"


class_name SimpleNode

var from : Label
var to : Label




func _ready():

	type = "normal"
	from = get_node("Connect/From")
	to = get_node("Connect/To")
	display_control = get_node("Display/LineEdit")
	line_control = get_node("Line/LineText")

	# TODO ESTO ESTA REPETIDO MÁS ARRIBA 
	pointer_control = get_node("Connect/To")


func set_index(index : int) -> void:
	# Si es el primer nodo, desconectar el slot izquierdo
	if index == 0:
		set_slot(0,false,0,Color(1,1,1),true,0,Color(0,1,0,1))
	from.text = index as String
	
func set_pointer(index : int) -> void:
	to.text = index as String


func get_index() -> int:
	return from.text as int

func get_display() -> String:
	return display_control.text


func get_line() -> String:
	return line_control.text
	

func get_pointer() -> int:
	return pointer_control.text as int
