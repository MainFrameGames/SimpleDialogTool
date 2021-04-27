extends GraphNode

#enum DIALOG_NODE_TYPES{NORMAL = "normal", CHOICE = "choice", END = "end"}

class_name DialogNode

# Node Type
var type : String
# Dialog numeric ID
var index : int

var display_control : LineEdit
var line_control : TextEdit
var pointer_control : Label


func _ready():
    connect("close_request",self,"_on_close_request")
    connect("resize_request",self,"_on_rezize_request")

    
func set_index(index : int) -> void:
    pass

    
func set_pointer(index : int) -> void:
    pass

func _on_close_request() -> void:
    queue_free()

func _on_rezize_request(new_size) -> void:
    rect_size = new_size


func get_index() -> int:
    print("Override this function")
    return -999999
    


func node_to_string() -> String:
    print("Override this function")
    return ""

func get_dialog_type() -> String:
    return type

func get_dialog_index() -> int:
    return index

func get_line() -> String:
    print("Override this function")
    return ""

func get_callbacks() -> Array:
    print("Override this function")
    return []

func get_display() -> String:
    print("Override this function")
    return ""

func get_pointer() -> int:
    print("Override this function")
    return -99999