extends VBoxContainer

var callback : String

# UI Controls
var line_edit : LineEdit
var callback_list : ItemList
var add_button : Button

func _ready():
	line_edit = get_node("HBoxContainer/LineEdit")
	callback_list = get_node("CallbackList")
	add_button = get_node("HBoxContainer/AddButton")


	add_button.connect("pressed",self,"_on_add_pressed")



func _on_add_pressed() -> void:
	# Recoger el texto del buffer del line edit
	callback = line_edit.text

	# Añadir al itemList
	callback_list.add_item(callback)

	# Reset del lineEdit
	line_edit.clear()
