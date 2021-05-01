extends VBoxContainer


class_name DecisionControl

var delete_button : Button
var callback_list : ItemList
var index_to : Label
var line_control : TextEdit

func _ready():
	
	# Control init
	delete_button = get_node("Delete")	
	callback_list = get_node("Callback/CallbackList")
	index_to = get_node("Connect/To")
	line_control = get_node("LineControl/LineText")

	# Signal connecting
	delete_button.connect("pressed", self, "_on_delete_decision")


# Self delete callback, deletes the node
func _on_delete_decision() -> void:
	queue_free()


# Get all the callbacks for this DecisionControl
func get_decision_callbacks() -> Array:
	
	var callbacks : Array
	
	for i in range(callback_list.get_item_count()):
		callbacks.append(callback_list.get_item_text(i))

	return callbacks


func get_decision_line() -> String:
	return line_control.text


func get_index_to() -> int:
	return index_to.text as int


func set_index_to(index : int) -> void:
	index_to.text = index as String
