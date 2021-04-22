extends Node

class_name Exporter


func export_project_callbacks(dialog_nodes : Array) -> String:
    var exported_callbacks : String = "extends Node\n\n"
    
    for i in dialog_nodes:
        var callbacks : Array = i.get_callbacks()
        for y in callbacks:
            exported_callbacks += callbacks[y] + "\n"
    
    return exported_callbacks


