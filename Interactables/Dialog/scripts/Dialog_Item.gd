@tool
@icon( "res://GUI/DialogSystem/icons/chat_bubble.svg" )
class_name DialogItem extends Node


@export var npc_info : NPC_Resource


var editor_selection : EditorSelection
var example_dialog : DialogSystem


func _ready() -> void:
	if Engine.is_editor_hint():
		editor_selection = EditorInterface.get_selection()
		return
	check_npc_data()



func check_npc_data() -> void:
	if npc_info == null:
		var p = self
		var _cheaking : bool = true
		while _cheaking == true:
			p.get_parent()
			if p:
				if p is NPC and p.npc_resource:
					npc_info = p.npc_resource
					_cheaking = false
				else:
					_cheaking = false
