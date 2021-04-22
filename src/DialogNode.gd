extends GraphNode

enum DIALOG_NODE_TYPES{NORMAL = "normal", CHOICE = "choice", END = "end"}

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


