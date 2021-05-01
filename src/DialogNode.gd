extends GraphNode

#enum DIALOG_NODE_TYPES{NORMAL = "normal", CHOICE = "choice", END = "end"}

class_name DialogNode

signal dialog_node_deleted(dialog_node_index)

# Node Type
var type : String
# Dialog numeric ID
var index_from : Label
# Dialog pointer 
var index_to : Label
# Control para indicar en que Displayer se mostrara el dialogo
var display_control : LineEdit
# Control para la línea de diálogo de este nodo
var line_control : TextEdit



func _ready():
	# Señales de cierrre y resize
	connect("close_request",self,"_on_close_request")
	connect("resize_request",self,"_on_rezize_request")

# Callback de cierre
func _on_close_request() -> void:
	emit_signal("dialog_node_deleted",index_from.text as int)
	# Remove al node connections before deleting
	clear_all_slots()
	#clear_slot(0)
	queue_free()


# Callback de resize del nodo
func _on_rezize_request(new_size) -> void:
	rect_size = new_size


# Métodos de la clase

func get_dialog_type() -> String:
	return type

func get_display() -> String:
	return display_control.text

func get_line() -> String:
	return line_control.text

# Metodos para ser sobrescritos en cada nodo específico para que respondan según el tipo

func set_index_from(index : int) -> void:
	pass

	
func set_index_to(index : int) -> void:
	pass


func get_index_from() -> int:
	print("Override this function")
	return -999999
	

func get_index_to() -> int:
	print("Override this function")
	return -99999

	
func get_callbacks() -> Array:
	print("Override this function")
	return []
