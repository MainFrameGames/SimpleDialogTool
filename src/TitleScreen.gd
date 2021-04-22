extends Control

const SDT_FILES_EXTENSION : String = ".tscn"
# Botones
var _new : Button 
var _exit : Button
var _load : Button

onready var file_explorer : FileDialog = get_node("FileDialog")
onready var alert_dialog : AcceptDialog = get_node("Alert")

func _ready():
	assert(file_explorer != null, "File explorer is null")
	
	# Inicializar botones y conectar callbacks
	_new = get_node("VBoxContainer/New")
	_exit = get_node("VBoxContainer/Exit")
	_load = get_node("VBoxContainer/Load")
	
	_new.connect("button_up",self,"_on_new_pressed")
	_exit.connect("button_up",self,"_on_exit_pressed")
	_load.connect("button_up",self,"_on_load_pressed")
	file_explorer.connect("file_selected",self,"_on_file_selected")



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
	file_explorer.popup_centered()


func _on_file_selected(path : String) -> void:
	
	# Comprobar que la extension del archivo sea TSCN
	if !path.ends_with(SDT_FILES_EXTENSION):
		print("Archivo no correcto")
		# TODO sacar a metodo
		alert_dialog.window_title = "Archivo incorrecto"
		alert_dialog.dialog_text = "El archivo seleccionado no es un archivo SDT de extensión .tscn"
		alert_dialog.popup_centered()
		
	else:
		# Abrir fichero 
		# Crear Instancia
		var scene = load(path)
		if Main.is_editor_file(scene.instance()):
			get_tree().change_scene_to(scene)
		else:
			alert_dialog.window_title = "Archivo incorrecto"
			alert_dialog.dialog_text = "El archivo seleccionado tiene extension .tscn pero no es un archivo de edición SDT"
			alert_dialog.popup_centered()	
		
	
	# Comprobar que sea una escena de tipo editor
	# Transicionar a esa escena
