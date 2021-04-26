extends GraphNode

#enum DIALOG_NODE_TYPES{NORMAL = "normal", CHOICE = "choice", END = "end"}

class_name DialogNode

# Node Type
var type : String
# Dialog numeric ID
var index : int
# Text line for this dialog
var line: String
# Display in which it should be shown
var display: String
# Callbacks that this dialog node emits
var callbacks : Array
# Index of the dialog node this dialog node points to
var pointer : int


func _ready():
    connect("close_request",self,"_on_close_request")
    connect("resize_request",self,"_on_rezize_request")

    
func set_index(index : int) -> void:
    
    self.index = index
    # Si es el primer nodo, desconectar el slot izquierdo
    if self.index == 0:
        set_slot(0,false,0,Color(1,1,1),true,0,Color(0,1,0,1))

func _on_close_request() -> void:
    queue_free()

func _on_rezize_request(new_size) -> void:
    rect_size = new_size


func node_to_string() -> String:
    print("Override this function")
    return ""

func get_dialog_type() -> String:
    return type

func get_dialog_index() -> int:
    return index