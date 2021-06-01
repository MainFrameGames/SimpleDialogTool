extends Control


var add_node_group : MenuButton
var export_node_group : MenuButton
var exit : Button
var guardar : Button


func _ready():
	# Init controls
	add_node_group = get_node("HBoxContainer/AñadirNodo")
	export_node_group = get_node("HBoxContainer/Exportar")
	exit = get_node("HBoxContainer/Salir")
	guardar = get_node("HBoxContainer/Guardar")
	# Connect signals
	add_node_group.get_popup().connect("id_pressed",self,"on_add_node_menu_pressed")
	export_node_group.get_popup().connect("id_pressed",self,"on_export_node_menu_pressed")
	exit.connect("pressed",self,"on_exit_pressed")
	guardar.connect("pressed",self,"_on_save_pressed")


# Add a new node pressed in the toolbar
func on_add_node_menu_pressed(index : int) -> void:
	Main.EVENTS.emit_signal("add_menu_item_selected",index)	

# Export option selected in the toolbar
func on_export_node_menu_pressed(index : int) -> void:
	Main.EVENTS.emit_signal("export_menu_item_selected",index)

# Exit the editor pressed
func on_exit_pressed() -> void:
	Main.EVENTS.emit_signal("exit_editor")

# Save project pressed
func _on_save_pressed() -> void:
	Main.EVENTS.emit_signal("save_project")
