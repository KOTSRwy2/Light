@tool
@icon( "res://GUI/DialogSystem/icons/chat_bubbles.svg" )
class_name DialogInteraction extends Area2D

signal player_intercated
signal finished

@export var enableed : bool = true

var dialog_items : Array[ DialogItem ]

@onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	area_entered.connect( _on_area_enter )
	area_exited.connect( _on_area_exit )
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append( c )


func player_interact() -> void:
	player_intercated.emit()
	await  get_tree().process_frame
	await  get_tree().process_frame
	Dialog_System.show_dialog( dialog_items )
	Dialog_System.finished.connect( _on_dialog_finished )
	pass


func _on_area_enter( _a : Area2D ) -> void:
	if enableed == false || dialog_items.size() == 0: 
		return
	animation_player.play("show")
	PlayerManager.interact_pressed.connect( player_interact )



func _on_area_exit( _a : Area2D ) -> void:
	animation_player.play("hide")
	PlayerManager.interact_pressed.disconnect( player_interact )
	pass


func _on_dialog_finished() -> void:
	Dialog_System.finished.disconnect( _on_dialog_finished )
	finished.emit()


func _get_configuration_warnings() -> PackedStringArray:
	if _check_for_dialog_items() == false:
		return [ "Require at least one DialogItem node" ]
	else:
		return []
	pass


func _check_for_dialog_items() -> bool:
	for c in get_children():
		if c is DialogItem:
			return true
	return false
