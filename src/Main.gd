extends Node

enum NODE_TYPES {NORMAL = 0, CHOICE = 1, END = 2, BEGIN = 3}
enum EXPORT_TYPES {JSON = 0, GDSCRIPT = 1, SIGNALS = 2, PROJECT = 3}

const DEFAULT_SAVE_PATH : String = "res://tmp/"
const UID : String = "xyz.mfgames.SDT.EDITOR_FILE"
onready var EVENTS : Events = Events.new()

var editor : PackedScene
var file_explorer : PackedScene

var normal_node : PackedScene
var choice_node : PackedScene
var end_node : PackedScene
var begin_node : PackedScene

func _ready():
	editor = preload("res://scenes/Editor.tscn")
	file_explorer = preload("res://scenes/windows/FileDialog.tscn")
	normal_node = preload("res://scenes/components/nodes/SimpleNode.tscn")
	choice_node = preload("res://scenes/components/nodes/ChoiceNode.tscn")
	end_node = preload("res://scenes/components/nodes/EndNode.tscn")
	begin_node = preload("res://scenes/components/nodes/BeginNode.tscn")

func get_new_editor() -> PackedScene:
	return editor

func get_file_explorer() -> PackedScene:
	return file_explorer


func get_graph_node_instance(type : int) -> Node:

	match type:
		NODE_TYPES.NORMAL:
			return normal_node.instance()
		NODE_TYPES.CHOICE:
			return choice_node.instance()
		NODE_TYPES.END:
			return end_node.instance()
		NODE_TYPES.BEGIN:
			return begin_node.instance()
		_:
			return normal_node.instance()



func get_normal_node_instance() -> Node:
	return normal_node.instance()

func get_uid() -> String:
	return UID

func exit() -> void:
	get_tree().quit()


func is_editor_file(scene : Node) -> bool:
	print(scene.name)
	assert(scene != null, "EDITOR NODE IS NULL")
	if scene != null && scene.has_method("get_uid"):
		if scene.get_uid() == Main.UID:
			return true
	return false
		

func display_alert(alert_title : String, alert_text : String) -> void:

	var alert : AcceptDialog = AcceptDialog.new()
	alert.window_title = alert_title
	alert.dialog_text = alert_text
	add_child(alert)
	alert.popup_centered()

	print(get_tree().to_string())
