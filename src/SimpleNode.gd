extends "res://src/DialogNode.gd"


class_name SimpleNode

var from : Label
var to : Label

func _ready():

	type = "normal"
	from = get_node("Connect/From")
	to = get_node("Connect/To")
	


