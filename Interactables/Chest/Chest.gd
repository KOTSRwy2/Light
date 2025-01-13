@tool
class_name TreasureChest extends Node2D

#@export var item_data : ItemData : set = _set_item_data
#@export var quantity : int = 1 : set = _set_quantity

@export var animation_set : String = "02"

var is_open : bool = false

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interact_area : Area2D = $InteractArea
@onready var audio : AudioStreamPlayer = $AudioStreamPlayer



func _ready() -> void:
	#_update_texture()
	#_update_label()
	if Engine.is_editor_hint():
		return
	interact_area.area_entered.connect( _on_area_enter )
	interact_area.area_exited.connect( _on_area_exit )
	#is_open_data.data_loaded.connect( set_cheat_state )
	#set_cheat_state()

func player_interact():
	if is_open == true:
		return
	else:
		#interact_area.monitoring = false ## optional
		is_open = true
		#is_open_data.set_value()
		animation_player.play("open_" + animation_set )


func _on_area_enter( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.connect( player_interact )
	pass


func _on_area_exit( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.disconnect( player_interact )
	pass

func set_cheat_state() -> void:
	#is_open = is_open_data.value
	if is_open:
		animation_player.play("open")
	else:
		animation_player.play("closed")




#func _set_item_data( value : ItemData ) -> void:
	#item_data = value
	#_update_texture()
	#pass



#func _set_quantity( value : int ) -> void:
	#quantity = value
	#_update_label()
	#pass
	

#func _update_texture() -> void:
	#if item_data and sprite:
		#sprite.texture = item_data.texture


#func _update_label() -> void:
	#if label:
		#if quantity <= 1:
		#	label.text = ""
		#else:
		#	label.text = "x" + str( quantity )
