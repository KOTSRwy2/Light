@tool
@icon( "res://NPC/icons/npc.svg" )
class_name NPC extends CharacterBody2D

signal do_behavior_enabled

var state : String = "idle"
var dirction : Vector2 = Vector2.DOWN
var direction_name : String = "down"
var do_behavior : bool = true

@onready var sprite : Sprite2D = $Sprite2D
@export var npc_resource : NPC_Resource : set = _set_npc_resource
@onready var animation : AnimationPlayer = $AnimationPlayer





func _ready() -> void:
	setup_npc()
	if Engine.is_editor_hint():
		return
	#gather_interactables()
	do_behavior_enabled.emit()
	pass



func _physics_process(delta : float) -> void:
	move_and_slide()



#func gather_interactables() -> void:
	#for c in get_children():
		#if c is DialogInteraction:
			#c.player_intercated.connect( _on_player_interacted )
			#c.finished.connect( _on_interaction_finished )



func update_animation() -> void:
	animation.play( state + "_" + direction_name )


func _on_player_interacted() -> void:
	update_dirction( PlayerManager.player.global_position )
	state = "idle"
	velocity = Vector2.ZERO
	update_animation()
	do_behavior = false
	
	pass


func _on_interaction_finished() -> void:
	state = "idle"
	update_animation()
	do_behavior = true
	do_behavior_enabled.emit()
	pass


func update_dirction( target_positon : Vector2 ) -> void:
	dirction = global_position.direction_to( target_positon )
	update_dirction_name()
	if direction_name == "side" and dirction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	

func update_dirction_name() -> void:
	var threshold : float = 0.45
	if dirction.y < -threshold:
		direction_name = "up"
	elif dirction.y > threshold:
		direction_name = "down"
	elif dirction.x < -threshold || dirction.x > threshold:
		direction_name = "side"
		

func setup_npc() -> void:
	if npc_resource:
		if sprite:
			sprite.texture = npc_resource.sprite



func _set_npc_resource( _npc : NPC_Resource ) -> void:
	npc_resource = _npc
	setup_npc()
	
