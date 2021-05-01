extends Control


var add_node_group : MenuButton
var export_node_group : MenuButton
var exit : Button

func _ready():
	add_node_group = get_node("HBoxContainer/AñadirNodo")
	export_node_group = get_node("HBoxContainer/Exportar")
	exit = get_node("HBoxContainer/Salir")
	add_node_group.get_popup().connect("id_pressed",self,"on_add_node_menu_pressed")
	export_node_group.get_popup().connect("id_pressed",self,"on_export_node_menu_pressed")
	exit.connect("pressed",self,"on_exit_pressed")


func on_add_node_menu_pressed(index : int) -> void:
	Main.EVENTS.emit_signal("add_menu_item_selected",index)	


func on_export_node_menu_pressed(index : int) -> void:
	Main.EVENTS.emit_signal("export_menu_item_selected",index)


func on_exit_pressed() -> void:
	Main.EVENTS.emit_signal("exit_editor")
