extends DialogNode


class_name DecisionNode

onready var decision_slot_index : int = 0

var add_decision_button : Button

export (PackedScene) var decision_control

func _ready():

	# Set type
	type = "decision"

	# Intialize controls
	add_decision_button = get_node("AddDecision")
	index_from = get_node("Connect/From")
	index_to = get_node("Connect/To")
	display_control = get_node("Display/LineEdit")
	line_control = get_node("Line/LineText")

	# Connect signals
	add_decision_button.connect("pressed",self,"_on_decission_add_pressed")


func set_index_from(index : int) -> void:
	index_from.text = index as String


func get_index_from() -> int:
	return index_from.text as int




# Funcionalidad extra del nodo de tipo Decision

func _on_decission_add_pressed() -> void:
	var instance = decision_control.instance()
	
	self.add_child(instance)

	set_slot(instance.get_index(),false,0,Color(1,1,1),true,0,Color(0,1,0,1))
	decision_slot_index += 1


func get_decisions() -> Dictionary:
	var decision_nodes : Array = get_tree().get_nodes_in_group("decision_control")
	var decisions_dictionary : Dictionary
	
	for i in range(decision_nodes.size()):

		var decision_array : Array
	
		decision_array.append(decision_nodes[i].get_decision_line())
		decision_array.append(decision_nodes[i].get_decision_callbacks())
		decision_array.append(decision_nodes[i].get_index_to())
		
		decisions_dictionary[i as String] = decision_array

	return decisions_dictionary


func set_decision_index(slot_index : int, index : int) -> void:
	#decision.get_node("Connect/To").text = index as String
	print(slot_index)
	print(index)
	var decision_controls = get_tree().get_nodes_in_group("decision_control")

	decision_controls[slot_index].get_node("Connect/To").text = index as String
	
