extends Control


# Botones
var _new : Button 
var _exit : Button
var _load : Button


func _ready():

	# Inicializar botones y conectar callbacks
	_new = get_node("VBoxContainer/New")
	_exit = get_node("VBoxContainer/Exit")
	_load = get_node("VBoxContainer/Load")
	
	_new.connect("button_up",self,"_on_new_pressed")
	_exit.connect("button_up",self,"_on_exit_pressed")
	_load.connect("button_up",self,"_on_load_pressed")




func _on_new_pressed() -> void:
	#get_tree().change_scene("")
	get_tree().change_scene_to(Main.get_new_editor())


func _on_exit_pressed() -> void:
	
	#var dialog : AcceptDialog = AcceptDialog.new()
	var dialog : ConfirmationDialog = ConfirmationDialog.new()

	dialog.dialog_text = "Salir del SDT?"
	dialog.add_cancel("Salir")
	add_child(dialog)
	dialog.popup_centered()

func _on_load_pressed() -> void:
	var file_explorer = Main.get_file_explorer().instance()
	add_child(file_explorer)
	file_explorer.get_node("FileDialog").popup_centered()
