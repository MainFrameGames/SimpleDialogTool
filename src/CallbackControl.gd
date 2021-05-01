extends VBoxContainer



# UI Controls
var line_edit : LineEdit
var callback_list : ItemList
var add_button : Button
var remove_button : Button
var repeated_callback_warning : AcceptDialog
var empty_callback_warning : AcceptDialog

func _ready():
	line_edit = get_node("HBoxContainer/LineEdit")
	callback_list = get_node("CallbackList")
	add_button = get_node("HBoxContainer/AddButton")
	remove_button = get_node("HBoxContainer/RemoveButton")
	repeated_callback_warning = get_node("RepeatedCallbackWarningDialog")
	empty_callback_warning = get_node("EmptyCallbackWarningDialog")

	add_button.connect("pressed",self,"_on_add_pressed")
	remove_button.connect("pressed",self,"_on_remove_pressed")

	# Ocultar el panel de la lista de callbacks al principio ya que
	# no hay nada que mostrar
	callback_list.visible = false



func _on_add_pressed() -> void:
	
	var callback : String
	# Recoger el texto del buffer del line edit
	callback = line_edit.text

	if callback.empty():
		empty_callback_warning.popup_centered()
	elif callback_is_repeated(callback):
		repeated_callback_warning.popup_centered()
	else:
		# Añadir al itemList
		callback_list.add_item(callback)

		# Reset del lineEdit
		line_edit.clear()

		# Hacer visible el item list
		callback_list.visible = true


func _on_remove_pressed() -> void:
	
	if callback_list.is_anything_selected():
		callback_list.remove_item(callback_list.get_selected_items()[0])
	else:
		Main.display_alert("Callback List","Seleccione una callback primero")
		
	if callback_list.get_item_count() == 0:
		callback_list.visible = false



func callback_is_repeated(callback : String) -> bool:
	
	for i in range(callback_list.get_item_count()):
		if callback_list.get_item_text(i) == callback:
			return true

	return false


func get_callbacks() -> Array:
	
	var callbacks : Array
	
	for i in range(callback_list.get_item_count()):
		callbacks.append(callback_list.get_item_text(i))

	return callbacks
