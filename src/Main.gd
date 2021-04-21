extends Node

enum NODE_TYPES {NORMAL = 0, CHOICE = 1, END = 2}

onready var EVENTS : Events = Events.new()

var editor : PackedScene
var file_explorer : PackedScene

var normal_node : PackedScene
var choice_node : PackedScene
var end_node : PackedScene

func _ready():
	editor = preload("res://scenes/Editor.tscn")
	file_explorer = preload("res://scenes/windows/FileDialog.tscn")
	normal_node = preload("res://scenes/components/nodes/SimpleNode.tscn")


func get_new_editor() -> PackedScene:
	return editor

func get_file_explorer() -> PackedScene:
	return file_explorer


func get_normal_node_instance() -> Node:
	return normal_node.instance()
